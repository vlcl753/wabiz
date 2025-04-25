import 'dart:convert';

import 'package:fastcampus_wabiz_client/shared/widgets/project_large_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../theme.dart';
import '../../view_model/favorite/favorite_view_model.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<String> tabs = ["펀딩", "메이커", "알림신청", "펀딩/프리오더", "스토어"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "관심 있는 소식만 모았어요",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.search),
                )
              ],
            ).p(16),
            Container(
              height: 32,
              padding: EdgeInsets.only(left: 16),
              child: ListView.builder(
                itemCount: tabs.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(right: 12),
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: AppColors.newBg,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Center(
                      child: Text(tabs[index]),
                    ),
                  );
                },
              ),
            ),
            Gap(12),
            Expanded(
              child: Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  final favorites = ref.watch(favoriteViewModelProvider);
                  if (favorites.projects.isEmpty) {
                    return Center(
                      child: Text("등록된 관심(구독) 프로젝트가 없어요."),
                    );
                  }
                  return ListView.builder(
                    itemCount: favorites.projects.length,
                    itemBuilder: (context, index) {
                      final project = favorites.projects[index];
                      return ProjectLargeWidget(projectDataString: jsonEncode(project.toJson()),showFavorite: true);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
