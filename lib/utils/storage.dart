import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../data/models/module.dart';
import '../data/models/source.dart';
import '../shared/constants/endpoints.dart';

class StorageManager {
  static Future<Source> saveModule(ModuleModel module) async {
    Dio dio = Dio();

    final modulePath = module.id.split('.')[1];
    final moduleDir = '${Endpoints.modulesDir}/${module.language}/$modulePath';

    try {
      final directory = await getApplicationDocumentsDirectory();
      final targetDirectory = Directory(
        join(directory.path, 'modules', module.id),
      );

      if (!targetDirectory.existsSync()) {
        targetDirectory.createSync(recursive: true);
      }

      final info = jsonEncode(module.toJson());

      File('${targetDirectory.path}/info.json').writeAsStringSync(info);

      dio.download(
        '$moduleDir/${module.icon}',
        '${targetDirectory.path}/${module.icon}',
      );
      dio.download(
        '$moduleDir/module.kaya',
        '${targetDirectory.path}/module.kaya',
      );

      return Source(
        moduleId: module.id,
        icon: module.icon,
        name: module.name,
        version: module.version,
        language: module.language,
        developer: module.developer,
        baseUrl: module.baseUrl,
        isInstalled: true,
        isEnabled: true,
        isPinned: false,
        path: targetDirectory.path,
      );
    } catch (e) {
      debugPrint('Error while saving files: $e');
      rethrow;
    }
  }
}
