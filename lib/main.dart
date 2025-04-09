import 'package:fastcampus_wabiz_client/router.dart';
import 'package:fastcampus_wabiz_client/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
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
