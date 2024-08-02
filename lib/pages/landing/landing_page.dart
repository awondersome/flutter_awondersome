import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awondersome/pages/landing/landing_page_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late Timer _timer;
  final LandingPageBloc _landingPageBloc = LandingPageBloc();

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_landingPageBloc.state.landingConfigModel.counter < 1) {
        _skip();
        return;
      }

      _landingPageBloc.add(CountEvent());
    });
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
    return BlocBuilder<LandingPageBloc, LandingPageState>(
      bloc: _landingPageBloc,
      builder: (context, state) {
        return Scaffold(
          body: Stack(children: [
            Visibility(
              visible: state.landingConfigModel.url.isNotEmpty,
              child: CachedNetworkImage(
                imageUrl: state.landingConfigModel.url,
                imageBuilder: (context, imageProvider) {
                  FlutterNativeSplash.remove();
                  // 加载页面之后才显示计数器，因为此时还处于启动页
                  _landingPageBloc.add(HaveLoadedNetworkImageEvent());
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
            Visibility(
              visible: state.isCounterVisible,
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: Center(
                            child: Text(
                          '跳过 ${state.landingConfigModel.counter}',
                          style: const TextStyle(color: Colors.white),
                        ))),
                  ),
                ),
              ),
            )
          ]),
        );
      },
    );
  }

  void _skip() {
    if (mounted) {
      context.go('/');
    }
  }
}
