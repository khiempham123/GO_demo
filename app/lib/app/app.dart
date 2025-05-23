import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_demo/modules/home/home_screen.dart';

part 'router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: _router);
  }
}
