import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awondersome/config/api.dart';
import 'package:flutter_awondersome/model/landing_model.dart';
import 'package:flutter_awondersome/service/http_util.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

/// 需要可配置的url和counter
class LandingPage extends StatefulWidget {
  const LandingPage({super.key, required this.title});

  final String title;

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late LandingModel _landingModel;
  late Timer _timer;
  ValueNotifier isLoaded = ValueNotifier(false);

  void _skip() {
    if (mounted) {
      context.go('/');
    }
  }

  void _getData() async {
    Map<String, dynamic> res = await GetIt.I<HttpUtil>().get(Api.landingUrl);
    setState(() {
      _landingModel = LandingModel.fromJson(res);
    });
    print(res);
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // 如果1秒内不能获取到landing的counter，就会默认跳过
      if (_landingModel.counter == 0) {
        _skip();

        return;
      }
      --_landingModel.counter;
    });
    _getData();
  }

  @override
  void dispose() {
    super.dispose();
    // 缓存图片如果加载不出来，6s后自动进入下一页
    FlutterNativeSplash.remove();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Center(
          child: CachedNetworkImage(
            imageUrl: _landingModel.url,
            imageBuilder: (context, imageProvider) {
              // 防止counter == 0秒且url.isNotEmpty时，第1秒会显示landing
              if (_landingModel.counter > 0) {
                FlutterNativeSplash.remove();
              }
              // 需要先return widget后才能setstate
              Future.delayed(Duration.zero, () {
                isLoaded.value = true;
              });
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        ValueListenableBuilder(
            valueListenable: isLoaded,
            builder: (context, value, child) => Visibility(
                  visible: value,
                  child: Positioned(
                    right: 16,
                    bottom: 16,
                    child: SafeArea(
                      child: InkWell(
                        onTap: _skip,
                        child: Container(
                            width: 60,
                            height: 30,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: Center(
                                child: Text(
                              '跳过 ${_landingModel.counter}',
                              style: const TextStyle(color: Colors.white),
                            ))),
                      ),
                    ),
                  ),
                )),
      ]),
    );
  }
}
