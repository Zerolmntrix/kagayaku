const _repo = "https://raw.githubusercontent.com/Zerolmntrix/kagayaku-modules";

abstract class Endpoints {
  static const _baseUrl = "$_repo/main/src";

  static const String modulesList = '$_baseUrl/modules.json';
  static const String modulesDir = '$_baseUrl/modules';
  static const String test =
      'https://raw.githubusercontent.com/Zerolmntrix/test_repo/main/module.kaya';
}
