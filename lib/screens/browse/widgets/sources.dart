import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../data/models/module.dart';
import '../../../data/models/source.dart';
import '../../../shared/theme/styles.dart';
import '../provider/provider.dart';
import 'module.dart';

class SourcesTab extends ConsumerWidget {
  const SourcesTab({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final installedSources = ref.watch(
      browseProvider.select(
          (value) => value.sources.where((v) => v.isInstalled).toList()),
    );

    installedSources.sort((a, b) => a.isPinned == b.isPinned
        ? 0
        : a.isPinned
            ? -1
            : 1);

    if (installedSources.isEmpty) {
      return const Center(child: Text('No sources enabled!'));
    }

    final enabledSources = installedSources
        .where(
          (e) => e.isInstalled && e.isEnabled,
        )
        .toList();

    return Scrollbar(
      child: ListView.builder(
        itemCount: enabledSources.length,
        itemBuilder: (context, index) {
          final source = enabledSources[index];
          return AnimatedSwitcher(
            duration: animationDuration,
            transitionBuilder: (child, animation) {
              return SlideTransition(
                position: animation.drive(
                  Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: const Offset(0, 0),
                  ),
                ),
                child: child,
              );
            },
            child: _IndividualModule(source, key: ValueKey(source.id)),
          );
        },
      ),
    );
  }
}

class _IndividualModule extends ConsumerWidget {
  final Source source;

  const _IndividualModule(this.source, {super.key});

  @override
  Widget build(BuildContext context, ref) {
    final colorScheme = Theme.of(context).colorScheme;

    final module = ModuleModel(
      id: source.moduleId,
      icon: source.icon,
      name: source.name,
      language: source.language,
      baseUrl: source.baseUrl,
      version: '',
      developer: source.developer,
    );

    toggleModulePin(ModuleModel model) {
      ref.read(browseProvider.notifier).togglePin(source);
    }

    return InkWell(
      onTap: () => context.push('/browse/${source.id}'),
      child: Module(
        module: module,
        trailing: IconButton(
          onPressed: () => toggleModulePin(module),
          isSelected: source.isPinned,
          icon: const Icon(Icons.push_pin_outlined),
          selectedIcon: Icon(Icons.push_pin, color: colorScheme.primary),
        ),
      ),
    );
  }
}
