import 'package:flutter_awondersome/bloc/config_bloc.dart';
import 'package:flutter_awondersome/service/logger_service.dart';
import 'package:get_it/get_it.dart';

import 'http_service.dart';

/// 非懒加载的单例为全局常用类，可以使用变量
final logger = GetIt.I.registerSingleton<LoggerService>(LoggerService()).logger;
final http = GetIt.I.registerSingleton<HttpService>(HttpService());

class Service {
  static Service get instance => _instance!;
  static Service? _instance;

  factory Service() {
    _instance ??= Service._internal();
    return _instance!;
  }

  Service._internal() {}

  setup() {
    GetIt.I..registerLazySingleton<ConfigBloc>(() => ConfigBloc());
  }
}
