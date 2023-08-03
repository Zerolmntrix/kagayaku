import 'package:http/http.dart' as http;

import '../../../shared/constants/endpoints.dart';

// TODO: Implement getModuleFromFile using device file system

Future<List<String>> getModuleFromFile() async {
  final response = await http.get(Uri.parse(Endpoints.test));

  final fileContent = response.body.split('\n').map((e) => e.trim()).toList();

  return fileContent;
}
