import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awondersome/app.dart';
import 'package:flutter_awondersome/extensions/dynamic_ext.dart';
import 'package:flutter_awondersome/service/storage_service.dart';
import 'package:flutter_awondersome/static/api.dart';
import 'package:flutter_awondersome/model/landing_config_model.dart';
import 'package:flutter_awondersome/bloc/config_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_ume/flutter_ume.dart';
import 'package:flutter_ume_kit_dio_plus/flutter_ume_kit_dio_plus.dart';

import 'service/service.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // 注册服务
  Service.setup();

  /// 通过接口判断是否要进入landing页面, 越快发起请求越好
  /// 应该用config_state来存储
  /// 独立的dio请求，设置延迟500ms，如果500ms内没有数据，就默认为不显示
  /// 等待请求完成后再进行，可以卡在启动页

  var res = await http.get(Api.landingUrl);
  GetIt.I<ConfigBloc>().add(SetLandingConfigEvent(
      landingConfigModel: LandingConfigModel.fromJson(res["data"])));
  storage.setMap(MapStorageKeys.landingConfig, res["data"].asMap());

  // 判断是否是第一次启动，第一次启动不用进入landing
  // 将landing的config存在local, 就不用在runapp前去请求
  // 该请求的优先级较低

  if (kDebugMode) {
    PluginManager.instance.register(DioInspector(dio: http.dio));

    runApp(UMEWidget(enable: true, child: MyApp()));
  } else {
    runApp(MyApp());
  }
}
