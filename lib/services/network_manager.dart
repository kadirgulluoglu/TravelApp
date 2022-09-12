import 'package:dio/dio.dart';

import '../models/base_model.dart';

class NetworkManager {
  static NetworkManager? _instance;
  static NetworkManager? get instance {
    _instance ??= NetworkManager._init();
    return _instance;
  }

  NetworkManager._init() {
    final baseOptions = BaseOptions(
      baseUrl: 'https://mocki.io/v1',
    );
    _dio = Dio(baseOptions);
  }

  Dio _dio = Dio();

  Future<dynamic> dioGet<T extends BaseModel>(String path,
      {T? model, Options? options, Map<String, dynamic>? map}) async {
    final response = await _dio.get(path,
        options: options ?? Options(), queryParameters: map ?? {});
    switch (response.statusCode) {
      case 200:
        final responseBody = response.data;

        if ((responseBody is List) && model != null) {
          return responseBody.map((e) => model.fromJson(e)).toList();
        } else if ((responseBody is Map) && model != null) {
          return model.fromJson(responseBody as Map<String, dynamic>);
        } else {
          return responseBody;
        }
      default:
    }
  }

  Future<dynamic> dioPost<T extends BaseModel>(String path, dynamic map,
      {T? model, Options? options}) async {
    final response =
        await _dio.post(path, data: map, options: options ?? Options());
    switch (response.statusCode) {
      case 200:
        final responseBody = response.data;
        if ((responseBody is List) && model != null) {
          return responseBody.map((e) => model.fromJson(e)).toList();
        } else if ((responseBody is Map) && model != null) {
          return model.fromJson(responseBody as Map<String, dynamic>);
        } else {
          return response.data;
        }
      case 201:
        final responseBody = response.data;
        if ((responseBody is List) && model != null) {
          return responseBody.map((e) => model.fromJson(e)).toList();
        } else if ((responseBody is Map) && model != null) {
          return model.fromJson(responseBody as Map<String, dynamic>);
        } else {
          return response.data;
        }
      default:
    }
  }
}
