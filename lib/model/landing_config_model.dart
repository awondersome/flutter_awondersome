import 'package:flutter/material.dart';
import 'package:flutter_awondersome/extensions/dynamic_ext.dart';

/// 只存储landing的配置
class LandingConfigModel {
  /// 是否需要跳转到landing页面
  bool isLanding = false;
  String url = '';
  int counter = 0;

  LandingConfigModel();

  LandingConfigModel.fromJson(Map<String, Object?> json) {
    isLanding = json["isLanding"].asBool();
    url = json["url"].asString();
    counter = json["counter"].asInt();
  }
}
