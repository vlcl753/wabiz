import 'package:fastcampus_wabiz_client/router.dart';
import 'package:fastcampus_wabiz_client/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'wabiz',
      routerConfig: router,
      theme: wabizDefaultTheme,
      themeAnimationStyle: AnimationStyle(
          curve: Curves.easeInCirc,
          duration: const Duration(microseconds: 1000)),
    );
  }
}
