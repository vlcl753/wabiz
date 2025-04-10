import 'package:fastcampus_wabiz_client/views/category/category_page.dart';
import 'package:fastcampus_wabiz_client/views/home/home_page.dart';
import 'package:fastcampus_wabiz_client/views/my/my_page.dart';
import 'package:fastcampus_wabiz_client/views/wabiz_app_shell.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: "/home",
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return WabizAppShell(
            child: child,
            currentIndex: switch (state.uri.path) {
              var p when p.startsWith("/my") => 3,
              _ => 0,
            });
      },
      routes: [
        GoRoute(
          path: '/home',
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) => const HomePage(),
          routes: [
            GoRoute(
              path: "category/:id",
              builder: (context, state) {
                final id = state.pathParameters['id'];
                return CategoryPage(categoryId: id ?? "0");
              },
            ),
          ],
        ),
        GoRoute(
          path: '/my',
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) => const MyPage(),
        ),
      ],
    )
  ],
);
