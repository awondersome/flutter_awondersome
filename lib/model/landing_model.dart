import 'package:flutter_awondersome/extension/map_ext.dart';

class LandingModel {
  String url = '';
  int counter = 0;

  LandingModel();

  LandingModel.fromJson(Map<String, dynamic> json) {
    url = json.of("url").toString();
    counter = json.of("counter").toInt();
  }
}
