import 'package:flutter_awondersome/extensions/dynamic_ext.dart';
import 'package:flutter_awondersome/pages/home_page.dart';
import 'package:flutter_awondersome/pages/landing/landing_page.dart';
import 'package:flutter_awondersome/pages/welcome/welcome_page.dart';
import 'package:flutter_awondersome/service/service.dart';
import 'package:flutter_awondersome/service/storage_service.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';

class MyRouter {
  static final config = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) =>
            const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomePage(),
      ),
      GoRoute(
        path: '/landing',
        builder: (context, state) => const LandingPage(),
      ),
    ],
    redirect: (context, state) {
      logger.d(state.extra);
      // 如果不加参数，会重定向到landing，然后又循环跳转到'/'
      if (state.fullPath == '/') {
        if (storage.getBool(BoolStorageKeys.isFisrtLaunch) &&
            !state.extra.asBool()) {
          FlutterNativeSplash.remove();
          return '/welcome';
        }
        if (storage.getMap(MapStorageKeys.landingConfig).isNotEmpty &&
            !state.extra.asBool()) {
          return '/landing';
        }
        FlutterNativeSplash.remove();
      }
      return null;
    },
  );
}
