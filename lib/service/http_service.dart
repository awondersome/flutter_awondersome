import 'package:dio/dio.dart';
import 'package:flutter_awondersome/static/api.dart';

class HttpService {
  static HttpService? _instance;

  factory HttpService() {
    _instance ??= HttpService._internal();
    return _instance!;
  }

  HttpService._internal() {
    Map<String, dynamic> headers = {
      'application-Name': 'jgcloud-app-dealer',
    };
    BaseOptions options = BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: headers);
    _dio = Dio(options);
  }

  Dio get dio => _dio;
  static late Dio _dio;

  Future<Map<String, dynamic>> get(String url) async {
    Map<String, dynamic> responseData = {};
    try {
      Response response = await _dio.get(Api.baseUrl + url);
      responseData = response.data;
    } on DioException catch (e) {
      responseData = {
        "code": 401,
        "data": {
          "url":
              "https://developer.huawei.com/allianceCmsResource/resource/HUAWEI_Developer_VUE/images/bannerpc12.jpg",
          "counter": 6,
          "isNeed": true,
        }
      };
    }

    return responseData;
  }
}
