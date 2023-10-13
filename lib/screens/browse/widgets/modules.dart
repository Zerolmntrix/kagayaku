import 'dart:convert';
import 'dart:isolate';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../data/methods/source.dart';
import '../../../data/models/module.dart';
import '../../../data/models/source.dart';
import '../../../shared/constants/endpoints.dart';
import '../../../shared/theme/styles.dart';
import '../../../utils/snackbar.dart';
import '../../../utils/storage.dart';
import '../provider/provider.dart';
import 'module.dart';
import 'settings.dart';

class ModulesTab extends ConsumerStatefulWidget {
  const ModulesTab({super.key});

  @override
  ConsumerState createState() => _ModulesTabState();
}

class _ModulesTabState extends ConsumerState<ModulesTab> {
  late final RefreshController _controller;

  late final Dio dio;

  @override
  void initState() {
    super.initState();
    dio = Dio();
    final loaded = ref.read(browseProvider.select((v) => v.loaded));
    _controller = RefreshController(initialRefresh: !loaded);
  }

  @override
  void dispose() {
    dio.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final installedModules = ref.watch(browseProvider.select(
      (v) => v.sources.where((e) => e.isInstalled).toList(),
    ));

    final availableModules = ref.watch(browseProvider.select((v) => v.modules));

    refresh() => _controller.requestRefresh();

    return Scrollbar(
      child: SmartRefresher(
        onRefresh: _fecthModules,
        controller: _controller,
        header: const SmartRefresherHeader(),
        child: ListView(
          children: [
            if (installedModules.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  'Installed modules',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ...installedModules.map((source) {
              return _SingleModule(
                  ModuleModel(
                    id: source.moduleId,
                    icon: source.icon,
                    name: source.name,
                    version: source.version,
                    language: source.language,
                    developer: source.developer,
                    baseUrl: source.baseUrl,
                  ),
                  isInstalled: source.isInstalled,
                  refresh: refresh);
            }).toList(),
            if (availableModules.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  'Available modules',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            for (ModuleModel module in availableModules)
              _SingleModule(module, isInstalled: false, refresh: refresh),
          ],
        ),
      ),
    );
  }

  _fecthModules() async {
    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      _controller.refreshFailed();
      _showMessage('No internet connection');
      return;
    }

    final CacheManager cache = DefaultCacheManager();
    FileInfo? fileInfo = await cache.getFileFromCache(Endpoints.modulesList);

    if (fileInfo != null && fileInfo.validTill.isAfter(DateTime.now())) {
      final String cachedData = await fileInfo.file.readAsString();
      final List data = jsonDecode(cachedData);

      _updateList(data, 'Loaded modules from cache');
      return;
    }

    final response = await dio.get(Endpoints.modulesList);

    if (response.statusCode != 200) {
      _controller.refreshFailed();
      _showMessage('Error while fecthing: ${response.statusCode}');
      return;
    }

    final List data = jsonDecode(response.data);

    final encodedFile = utf8.encoder.convert(response.data);
    const duration = Duration(hours: 1);

    cache.putFile(Endpoints.modulesList, encodedFile, maxAge: duration);
    _updateList(data, 'Loaded modules from network');
  }

  _updateList(List data, String? debugMessage) async {
    final List<ModuleModel> modules = [];

    for (var source in data) {
      final parts = source['id'].split('.');

      final moduleLang = parts[0];
      final modulePath = parts[1];

      final response = await dio.get(
        '${Endpoints.modulesDir}/$moduleLang/$modulePath/info.json',
      );

      final Map<String, dynamic> info = jsonDecode(response.data);

      info.addAll(
        {"id": source["id"], "version": source["version"]},
      );

      modules.add(ModuleModel.fromJson(info));
    }

    ref.read(browseProvider.notifier).setModules(modules);

    _controller.refreshCompleted();
    debugPrint(debugMessage ?? 'Updated modules list');
  }

  _showMessage(String message) => showSnackBar(context, message);
}

class _SingleModule extends ConsumerStatefulWidget {
  final ModuleModel module;
  final bool isInstalled;
  final Function refresh;

  const _SingleModule(
    this.module, {
    required this.isInstalled,
    required this.refresh,
  });

  @override
  ConsumerState createState() => _SingleModuleState();
}

class _SingleModuleState extends ConsumerState<_SingleModule> {
  bool isInstalling = false;
  late bool isInstalled;
  Isolate? _installationIsolate;
  final ReceivePort _installationPort = ReceivePort();

  show(String message) => showSnackBar(context, message);

  @override
  void initState() {
    super.initState();
    final moduleName = widget.module.name;

    isInstalled = widget.isInstalled;

    _installationPort.listen((message) => _onMessage(message, moduleName));
  }

  @override
  dispose() {
    _installationPort.close();
    _installationIsolate?.kill();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final module = widget.module;

    // TODO: Add a way to check if has an update
    onModuleTap() async {
      if (isInstalled) {
        _openModuleSettings(module.id);
      } else if (isInstalling) {
        _cancelInstallation(module.id);
      } else {
        RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;

        _installationIsolate = await Isolate.spawn(
          _installModule,
          [
            _installationPort.sendPort,
            module,
            rootIsolateToken,
          ],
        );
      }
    }

    return InkWell(
      onTap: onModuleTap,
      child: Module(
        module: module,
        loading: isInstalling,
        trailing: IconButton(
          onPressed: onModuleTap,
          isSelected: isInstalled,
          icon: !isInstalling
              ? const Icon(Icons.download)
              : const Icon(Icons.close),
          selectedIcon: const Icon(Icons.settings),
        ),
      ),
    );
  }

  static _installModule(List args) async {
    final sendPort = args[0] as SendPort;
    final module = args[1] as ModuleModel;
    final rootIsolateToken = args[2] as RootIsolateToken;

    sendPort.send("install");

    BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);
    try {
      Source source = await StorageManager.saveModule(module);
      try {
        Source dbSource = await SourceMethods.readSource(source.moduleId);
        await SourceMethods.update(
          dbSource.copy(isEnabled: true, isInstalled: true),
        );
      } catch (e) {
        await SourceMethods.create(source);
      }

      sendPort.send("completed");
    } catch (e) {
      sendPort.send("error");
    }
  }

  _cancelInstallation(String moduleId) async {
    _installationIsolate?.kill(priority: Isolate.immediate);

    ref.read(browseProvider.notifier).removeSource(moduleId);

    _installationPort.sendPort.send("cancelled");
  }

  _openModuleSettings(String moduleId) async {
    final source = await SourceMethods.readSource(moduleId);

    if (!context.mounted) return;

    confirmUninstall(String moduleId) async {
      setState(() => isInstalled = false);
      ref.read(browseProvider.notifier).removeSource(moduleId);
      widget.refresh();
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => ModuleSettings(
        source: source,
        uninstall: confirmUninstall,
      ),
    );
  }

  _onMessage(String message, String module) {
    if (message == "install") {
      setState(() => isInstalling = true);
    } else if (message == "completed") {
      setState(() {
        isInstalling = false;
        isInstalled = true;
      });
      final modules = ref.read(browseProvider.select((v) => v.modules));
      ref.read(browseProvider.notifier).setModules(modules);
      show('Installed: $module');
    } else if (message == "cancelled") {
      setState(() => isInstalling = false);
      show('Cancelled: $module');
    } else if (message == "error") {
      setState(() => isInstalling = false);
      show('Error while installing: $module');
    }
  }
}
