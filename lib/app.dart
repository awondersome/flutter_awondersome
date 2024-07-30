import 'package:flutter/material.dart';
import 'package:flutter_awondersome/pages/home_page.dart';
import 'package:flutter_awondersome/pages/landing_page.dart';
import 'package:go_router/go_router.dart';

class MyApp extends StatelessWidget {
  // GoRouter configuration
  final _router = GoRouter(
    initialLocation: '/welcome',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) =>
            const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
      GoRoute(
        path: '/welcome',
        builder: (context, state) =>
            const LandingPage(title: 'Flutter Demo Home Page'),
      ),
    ],
  );
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}
