import 'package:flutter_awondersome/bloc/config_bloc.dart';
import 'package:flutter_awondersome/service/logger_service.dart';
import 'package:flutter_awondersome/service/storage_service.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'http_service.dart';

/// 非懒加载的单例为全局常用类，可以使用全局变量
final logger = GetIt.I.registerSingleton<LoggerService>(LoggerService()).logger;
final http = GetIt.I.registerSingleton<HttpService>(HttpService());
final storage = GetIt.I<StorageService>();

class Service {
  static Service? _instance;

  factory Service() {
    _instance ??= Service._internal();
    return _instance!;
  }

  Service._internal();

  static setup() {
    GetIt.I.registerSingletonAsync<StorageService>(() async {
      final appDocumentDir = await getApplicationDocumentsDirectory();
      await Hive.initFlutter(appDocumentDir.path);
      await StorageService.init();
      return StorageService();
    });
    GetIt.I..registerLazySingleton<ConfigBloc>(() => ConfigBloc());
  }
}
