import 'package:flutter/material.dart';
import 'package:flutter_awondersome/pages/home_page.dart';
import 'package:flutter_awondersome/pages/landing/landing_page.dart';
import 'package:flutter_awondersome/bloc/config_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
        builder: (context, state) => const LandingPage(),
      ),
    ],
  );

  ///
  ///
  ///

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
