import 'package:dio/dio.dart';

import '../../../shared/constants/endpoints.dart';

// TODO: Implement getModuleFromFile using device file system

Future<List<String>> getSourceFromFile() async {
  Dio dio = Dio();

  final module = await dio.get(Endpoints.test);
  final moduleContent = module.data.toString().split('\n');

  final moduleContentList = moduleContent
      .where((element) => element.isNotEmpty)
      .where((element) => !element.startsWith('//'))
      .map((e) => e.trim())
      .toList();

  dio.close();

  return moduleContentList;
}
