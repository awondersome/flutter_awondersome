import 'package:dio/dio.dart';
import 'package:flutter_awondersome/config/api.dart';

class HttpUtil {
  static HttpUtil? _instance;

  factory HttpUtil() {
    _instance ??= HttpUtil._internal();
    return _instance!;
  }

  HttpUtil._internal() {
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
              "https://developer.huawei.com/allianceCmsResource/resource/HUAWEI_Developer_VUE/images/bannerpc12.jpg"
        }
      };
    }

    return responseData;
  }
}
