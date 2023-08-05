import 'package:http/http.dart' as http;

import '../../../shared/constants/endpoints.dart';

// TODO: Implement getModuleFromFile using device file system

Future<List<String>> getSourceFromFile() async {
  final module = await http.get(Uri.parse(Endpoints.test));
  final moduleContent = module.body.split('\n');

  final moduleContentList = moduleContent
      .where((element) => element.isNotEmpty)
      .where((element) => !element.startsWith('//'))
      .map((e) => e.trim())
      .toList();

  return moduleContentList;
}
