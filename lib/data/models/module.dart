class ModuleModel {
  final String id;
  final String icon;
  final String name;
  final String version;
  final String language;

  ModuleModel({
    required this.id,
    required this.icon,
    required this.name,
    required this.version,
    required this.language,
  });

  factory ModuleModel.fromJson(Map<String, dynamic> json) {
    return ModuleModel(
      id: json['id'],
      icon: json['icon'],
      name: json['name'],
      version: json['version'],
      language: json['language'],
    );
  }

  Map<String, dynamic> toJson(String developer, String baseUrl) {
    return {
      'id': id,
      'icon': icon,
      'name': name,
      'version': version,
      'language': language,
      'developer': developer,
      'baseUrl': baseUrl,
    };
  }
}
