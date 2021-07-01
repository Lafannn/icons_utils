import 'package:dio/dio.dart';
import 'package:icons_utils/models/selection.dart';

class IcomoonClient {
  final _dio = Dio(BaseOptions(baseUrl: 'https://i.icomoon.io/public/'));

  final bool isTemp;
  final String hostId;
  final String projectName;

  IcomoonClient(this.isTemp, this.hostId, this.projectName);

  Future<Selection> getSelection() async {
    final selectionResponse = await _dio.get(
      '${isTemp ? "temp" : ""}/$hostId/$projectName/selection.json',
    );

    final selection = Selection.fromJson(selectionResponse.data);
    return selection;
  }

  Future<List<int>?> getTTF(String fontName) async {
    final ttf = await _dio.get<List<int>>(
      '${isTemp ? "temp" : ""}/$hostId/$projectName/$fontName.ttf',
      options: Options(responseType: ResponseType.bytes),
    );

    return ttf.data;
  }
}
