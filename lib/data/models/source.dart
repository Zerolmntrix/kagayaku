import '../../shared/constants/db_types.dart';

const tableSources = '''
      CREATE TABLE ${SourceFields.tableName} (
       ${SourceFields.id} $kIntType PRIMARY KEY AUTOINCREMENT,
       ${SourceFields.moduleId} $kTextType,
       ${SourceFields.icon} $kTextType,     
       ${SourceFields.name} $kTextType, 
       ${SourceFields.version} $kTextType, 
       ${SourceFields.language} $kTextType, 
       ${SourceFields.developer} $kTextType, 
       ${SourceFields.baseUrl} $kTextType, 
       ${SourceFields.isInstalled} $kBoolType,
       ${SourceFields.isEnabled} $kBoolType,
       ${SourceFields.isPinned} $kBoolType,
       ${SourceFields.path} $kTextType
      )
    ''';

class SourceFields {
  static const String tableName = 'sources';

  static const values = [
    id,
    moduleId,
    icon,
    name,
    version,
    language,
    developer,
    baseUrl,
    isInstalled,
    isEnabled,
    isPinned,
    path,
  ];

  static const String id = 'id';
  static const String moduleId = 'moduleId';
  static const String icon = 'icon';
  static const String name = 'name';
  static const String version = 'version';
  static const String language = 'language';
  static const String developer = 'developer';
  static const String baseUrl = 'baseUrl';
  static const String isInstalled = 'isInstalled';
  static const String isEnabled = 'isEnabled';
  static const String isPinned = 'isPinned';
  static const String path = 'path';
}

class Source {
  final int? id;
  final String moduleId;
  final String icon;
  final String name;
  final String version;
  final String language;
  final String developer;
  final String baseUrl;
  final bool isInstalled;
  final bool isEnabled;
  final bool isPinned;
  final String path;

  Source({
    this.id,
    required this.moduleId,
    required this.icon,
    required this.name,
    required this.version,
    required this.language,
    required this.developer,
    required this.baseUrl,
    required this.isInstalled,
    required this.isEnabled,
    required this.isPinned,
    required this.path,
  });

  Source copy({
    int? id,
    String? moduleId,
    String? icon,
    String? name,
    String? version,
    String? language,
    String? developer,
    String? baseUrl,
    bool? isInstalled,
    bool? isEnabled,
    bool? isPinned,
    String? path,
  }) =>
      Source(
        id: id ?? this.id,
        moduleId: moduleId ?? this.moduleId,
        icon: icon ?? this.icon,
        name: name ?? this.name,
        version: version ?? this.version,
        language: language ?? this.language,
        developer: developer ?? this.developer,
        baseUrl: baseUrl ?? this.baseUrl,
        isInstalled: isInstalled ?? this.isInstalled,
        isEnabled: isEnabled ?? this.isEnabled,
        isPinned: isPinned ?? this.isPinned,
        path: path ?? this.path,
      );

  Map<String, Object?> toJson() => {
        SourceFields.id: id,
        SourceFields.moduleId: moduleId,
        SourceFields.icon: icon,
        SourceFields.name: name,
        SourceFields.version: version,
        SourceFields.language: language,
        SourceFields.developer: developer,
        SourceFields.baseUrl: baseUrl,
        SourceFields.isInstalled: isInstalled ? 1 : 0,
        SourceFields.isEnabled: isEnabled ? 1 : 0,
        SourceFields.isPinned: isPinned ? 1 : 0,
        SourceFields.path: path,
      };

  static Source fromJson(Map<String, Object?> json) => Source(
        id: json[SourceFields.id] as int,
        moduleId: json[SourceFields.moduleId] as String,
        icon: json[SourceFields.icon] as String,
        name: json[SourceFields.name] as String,
        version: json[SourceFields.version] as String,
        language: json[SourceFields.language] as String,
        developer: json[SourceFields.developer] as String,
        baseUrl: json[SourceFields.baseUrl] as String,
        isInstalled: json[SourceFields.isInstalled] == 1,
        isEnabled: json[SourceFields.isEnabled] == 1,
        isPinned: json[SourceFields.isPinned] == 1,
        path: json[SourceFields.path] as String,
      );
}
