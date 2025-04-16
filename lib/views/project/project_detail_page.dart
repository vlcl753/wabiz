import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fastcampus_wabiz_client/model/category/category_model.dart';
import 'package:fastcampus_wabiz_client/model/project/project_model.dart';
import 'package:fastcampus_wabiz_client/theme.dart';
import 'package:fastcampus_wabiz_client/view_model/project/project_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../view_model/favorite/favorite_view_model.dart';
import 'detail/project_detail_widget.dart';

class ProjectDetailPage extends StatefulWidget {
  final String project;

  const ProjectDetailPage({super.key, required this.project});

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  late ProjectItemModel projectItemModel;
  ValueNotifier<bool> isMore = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    projectItemModel = ProjectItemModel.fromJson(
      json.decode(widget.project),
    );
    print(projectItemModel);
  }

  @override
  void dispose() {
    isMore.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.go('/home');
            },
            icon: SvgPicture.asset("assets/icons/home_outlined.svg",
                width: 24, height: 24),
          ),
        ],
      ),
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final project = ref.watch(
              projectDetailViewModelProvider(projectItemModel.id.toString()));
          return project.when(data: (data) {
            return Column(
              children: [
                Container(
                  height: 220,
                  decoration: BoxDecoration(
                    color: Colors.grey[300]!,
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                          projectItemModel.thumbnail ?? ""),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(.2), BlendMode.darken),
                    ),
                  ),
                ),
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: isMore,
                    builder: (context, value, child) {
                      return Stack(
                        children: [
                          Positioned.fill(
                            child: SingleChildScrollView(
                              physics: !value
                                  ? NeverScrollableScrollPhysics()
                                  : BouncingScrollPhysics(),
                              child: ProjectWidget(data: data),
                            ),
                          ),
                          if (!value)
                            Positioned(
                              left: 16,
                              right: 16,
                              bottom: 0,
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Colors.white,
                                        Colors.white,
                                        Colors.white,
                                        Colors.white.withOpacity(.1),
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter),
                                ),
                              ),
                            ),
                          if (!value)
                            Positioned(
                              left: 16,
                              right: 16,
                              bottom: 16,
                              child: GestureDetector(
                                onTap: () => isMore.value = true,
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border:
                                        Border.all(color: AppColors.primary),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "스토리 더보기",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: AppColors.primary),
                                      ),
                                      Gap(12),
                                      Icon(
                                        Icons.keyboard_arrow_down,
                                        color: AppColors.primary,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          }, error: (error, trace) {
            return Text("error: ${error.toString()}");
          }, loading: () {
            return Center(child: CircularProgressIndicator());
          });
        },
      ),
      bottomNavigationBar: _BottomAppBar(projectItemModel),
    );
  }
}

class _BottomAppBar extends ConsumerWidget {
  final ProjectItemModel projectItemModel;

  const _BottomAppBar(this.projectItemModel, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoriteViewModelProvider);
    final current = favorites.projects
        .where((element) => element.id == projectItemModel.id)
        .toList();
    return BottomAppBar(
      height: 84,
      color: Colors.white,
      surfaceTintColor: Colors.white,
      padding: EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey[200]!),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 4),
        child: Row(
          children: [
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    if (current.isNotEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text("구독을 취소할까요?"),
                            title: Text("네"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  ref
                                      .read(favoriteViewModelProvider.notifier)
                                      .removeItem(
                                        CategoryItemModel(
                                            id: projectItemModel.id),
                                      );
                                },
                                child: Text("네"),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      ref.read(favoriteViewModelProvider.notifier).addItem(
                            CategoryItemModel(
                                id: projectItemModel.id,
                                thumbnail: projectItemModel.thumbnail,
                                description: projectItemModel.description,
                                title: projectItemModel.title,
                                owner: projectItemModel.owner,
                                totalFunded: projectItemModel.totalFunded,
                                totalFundedCount:
                                    projectItemModel.totalFundedCount),
                          );
                    }
                  },
                  icon: Icon(
                    current.isEmpty ? Icons.favorite_border : Icons.favorite,
                    color: current.isEmpty ? Colors.white : Colors.red,
                  ),
                ),
                Text("1만+")
              ],
            ),
            Gap(12),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10)),
              height: 50,
              child: Center(
                child: Text(
                  "펀딩하기",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 16),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
