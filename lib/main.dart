import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awondersome/app.dart';
import 'package:flutter_awondersome/config/api.dart';
import 'package:flutter_awondersome/service/http_util.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_ume/flutter_ume.dart';
import 'package:flutter_ume_kit_dio_plus/flutter_ume_kit_dio_plus.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // 注册服务
  GetIt.I.registerSingleton<HttpUtil>(HttpUtil());
  GetIt.I.registerSingleton<Api>(Api());

  if (kDebugMode) {
    PluginManager.instance.register(DioInspector(dio: GetIt.I<HttpUtil>().dio));

    runApp(UMEWidget(enable: true, child: MyApp()));
  } else {
    runApp(MyApp());
  }
}
