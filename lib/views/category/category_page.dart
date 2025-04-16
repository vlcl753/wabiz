import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fastcampus_wabiz_client/theme.dart';
import 'package:fastcampus_wabiz_client/view_model/category/category_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../view_model/favorite/favorite_view_model.dart';

class CategoryPage extends ConsumerStatefulWidget {
  const CategoryPage({super.key, required this.categoryId});

  final String categoryId;

  @override
  ConsumerState<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends ConsumerState<CategoryPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(categoryViewModelProvider.notifier)
          .fetchProjects(widget.categoryId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('카테고리'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/icons/home_outlined.svg',
                width: 24, height: 24),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 204,
            child: Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final datas =
                    ref.watch(fetchCategoryProjectsProvider(widget.categoryId));
                return datas.when(
                  data: (data) {
                    final titleProject = data
                        .projects[Random().nextInt((data.projects.length) - 1)];
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              titleProject.thumbnail ?? ""),
                          fit: BoxFit.fill,
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(.2), BlendMode.darken),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "${titleProject.title}"
                              .text
                              .textStyle(
                                const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white),
                              )
                              .make(),
                          const Gap(12),
                          "${titleProject.description}"
                              .text
                              .maxLines(1)
                              .overflow(
                                TextOverflow.ellipsis,
                              )
                              .color(Colors.white)
                              .make(),
                          const Gap(16),
                          Container(
                            height: 4,
                            width: 120,
                            decoration:
                                const BoxDecoration(color: Colors.white),
                          )
                        ],
                      ),
                    );
                  },
                  error: (Object error, StackTrace stackTrace) {
                    return Center(
                      child: '${error.toString()}'.text.make(),
                    );
                  },
                  loading: () {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            height: 120,
            decoration: const BoxDecoration(color: Colors.white),
            padding: const EdgeInsets.fromLTRB(0, 16, 8, 0),
            child: Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final types = ref.watch(fetchTypeTabsProvider);
                return types.when(
                  data: (data) {
                    return Consumer(
                      builder:
                          (BuildContext context, WidgetRef ref, Widget? child) {
                        final vm = ref.watch(categoryViewModelProvider);
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final tab = data[index];
                            return GestureDetector(
                              onTap: () {
                                ref
                                    .read(categoryViewModelProvider.notifier)
                                    .updateType(tab);
                                ref
                                    .read(categoryViewModelProvider.notifier)
                                    .fetchProjects(widget.categoryId);
                                print(vm.selectedType);
                                print(tab.type);
                              },
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: index == 0 ? 22 : 32),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Gap(8),
                                    SvgPicture.asset(tab.imagePath ?? '',
                                        width: 32, height: 32),
                                    const Gap(12),
                                    "${tab.type}"
                                        .text
                                        .fontWeight(
                                            vm.selectedType?.type == tab.type
                                                ? FontWeight.bold
                                                : FontWeight.normal)
                                        .align(TextAlign.center)
                                        .make(),
                                    const Gap(12),
                                    Container(
                                      width: 40,
                                      height: 6,
                                      color: vm.selectedType?.type == tab.type
                                          ? Colors.black
                                          : Colors.transparent, // ✅ 너비 자동 적용됨
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  error: (e, trace) {
                    return Center(
                      child: '$e'.text.make(),
                    );
                  },
                  loading: () => Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                );
              },
            ),
          ),
          const Divider(
            height: 0,
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Consumer(
              builder: (BuildContext context, ref, Widget? child) {
                final projects =
                    ref.watch(categoryViewModelProvider).projectState;
                return projects.when(
                  data: (data) {
                    if (data.isEmpty) {
                      return Center(child: "등록된 프로젝트가 없습니다.".text.make());
                    }
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            children: [
                              DropdownButton(
                                items: [
                                  DropdownMenuItem(
                                    child: '전체'.text.make(),
                                  ),
                                ],
                                onChanged: (value) {},
                                icon: const Icon(Icons.arrow_drop_down),
                              ),
                              const Gap(24),
                              Consumer(builder: (context, ref, child) {
                                final filter = ref
                                    .watch(categoryViewModelProvider)
                                    .projectFilter;

                                return DropdownButton(
                                  value: filter,
                                  items:
                                      EnumCategoryProjectType.values.map((e) {
                                    return DropdownMenuItem(
                                      value: e,
                                      onTap: () {
                                        ref
                                            .read(categoryViewModelProvider
                                                .notifier)
                                            .updateProjectFilter(e);
                                      },
                                      child: Text("${e.value}"),
                                    );
                                  }).toList(),
                                  onChanged: (value) {},
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                  ),
                                  underline: const SizedBox.shrink(),
                                );
                              }),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final project = data[index];
                              return Padding(
                                padding: EdgeInsets.only(bottom: 25),
                                child: InkWell(
                                  onTap: () {
                                    context.push(
                                      "/detail",
                                      extra: json.encode(
                                        project.toJson(),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 120,
                                        width: 164,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.black.withOpacity(.2),
                                          image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                                project.thumbnail ?? ""),
                                            fit: BoxFit.fill,
                                            colorFilter: ColorFilter.mode(
                                                Colors.black.withOpacity(.2),
                                                BlendMode.darken),
                                          ),
                                        ),
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              right: 2,
                                              top: 2,
                                              child: Consumer(
                                                builder: (BuildContext context,
                                                    WidgetRef ref,
                                                    Widget? child) {
                                                  final favorites = ref.watch(
                                                      favoriteViewModelProvider);
                                                  final current = favorites
                                                      .projects
                                                      .where((element) =>
                                                          element.id ==
                                                          project.id)
                                                      .toList();
                                                  return IconButton(
                                                    onPressed: () {
                                                      if (current.isNotEmpty) {
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return AlertDialog(
                                                                content: Text(
                                                                    "구독을 취소할까요?"),
                                                                actions: [
                                                                  TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      ref
                                                                          .read(favoriteViewModelProvider
                                                                              .notifier)
                                                                          .removeItem(
                                                                              project);
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                    child: Text(
                                                                        "네"),
                                                                  )
                                                                ],
                                                              );
                                                            });
                                                        return;
                                                      }
                                                      ref
                                                          .read(
                                                              favoriteViewModelProvider
                                                                  .notifier)
                                                          .addItem(project);
                                                    },
                                                    icon: Icon(current.isEmpty
                                                        ? Icons.favorite_border
                                                        : Icons.favorite),
                                                    color: current.isNotEmpty
                                                        ? Colors.red
                                                        : Colors.white,
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Gap(16),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          "${project.title}"
                                              .text
                                              .maxLines(2)
                                              .overflow(TextOverflow.ellipsis)
                                              .make(),
                                          const Gap(8),
                                          '${project.owner}'
                                              .text
                                              .size(12)
                                              .color(AppColors.wabizGray[500])
                                              .make(),
                                          const Gap(8),
                                          '${NumberFormat("###,###,###").format(project.totalFundedCount)} 명 참여'
                                              .text
                                              .color(AppColors.primary)
                                              .fontWeight(FontWeight.w600)
                                              .make(),
                                          const Gap(8),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 6, vertical: 4),
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(3)),
                                                color: AppColors.bg),
                                            child: Text(
                                              switch (
                                                  project.totalFunded ?? 0) {
                                                >= 100000000 && > 10000000 =>
                                                  "${NumberFormat.currency(
                                                    locale: "ko_KR",
                                                    symbol: "",
                                                  ).format((project.totalFunded ?? 0) ~/ 100000000)}억 원+",
                                                >= 10000000 && > 10000 =>
                                                  "${NumberFormat.currency(
                                                    locale: "ko_KR",
                                                    symbol: "",
                                                  ).format((project.totalFunded ?? 0) ~/ 10000000)}천만 원+",
                                                > 10000 =>
                                                  "${NumberFormat.currency(
                                                    locale: "ko_KR",
                                                    symbol: "",
                                                  ).format((project.totalFunded ?? 0) ~/ 10000)}만 원+",
                                                _ => "",
                                              },
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          )
                                        ],
                                      ))
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                  error: (Object error, StackTrace stackTrace) {
                    return Center(
                      child: Text(
                        error.toString(),
                      ),
                    );
                  },
                  loading: () {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
              },
            ),
          ))
        ],
      ),
    );
  }
}
