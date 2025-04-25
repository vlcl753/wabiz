import 'package:dio/dio.dart';
import 'package:fastcampus_wabiz_client/model/home/home_model.dart';
import 'package:fastcampus_wabiz_client/repository/home/home_repository.dart';
import 'package:fastcampus_wabiz_client/views/home/home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../shared/model/category.dart';

part 'home_view_model.freezed.dart';
part 'home_view_model.g.dart';


@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default([]) List<HomeItemModel> projects,
  }) = _HomeState;

  factory HomeState.fromJson(Map<String, dynamic> json) =>
      _$HomeStateFromJson(json);
}




@riverpod
class HomeViewModel extends _$HomeViewModel {
  HomeRepository? homeRepository;

  @override
  HomeState? build() {
    homeRepository = ref.watch(homeRepositoryProvider);
    return null;
  }

  update(List<HomeItemModel> projects) {
    state = state?.copyWith(
      projects: [...projects],
    );
  }

  Future<HomeModel?> fetchHomeData() async {
    final result = await homeRepository?.getHomeProjects();
    update(result?.projects ?? []);
    return result;
  }
}


///홈 화면에 보여지는 프로젝트 리스트를 가져오는 provider
@riverpod
Future<HomeModel> fetchHomeProject(Ref ref) async {
  try {
    final result =
        await ref.watch(homeViewModelProvider.notifier).fetchHomeData();
    return result ?? const HomeModel();
  } on DioException catch (error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        throw ConnectionTimeoutError(error);
      case DioExceptionType.connectionError:
        throw ConnectionError(error);
        default:
    }
    return const HomeModel();
  }
}

///홈 화면에 보여지는 카테고리 리스트를 가져오는 provider

@riverpod
Future<List<ProjectCategory>> fetchHomeCategorys(Ref ref) async {
  await Future.delayed(const Duration(milliseconds: 500));
  List<ProjectCategory> categorys = [
    const ProjectCategory(
      id: 1,
      iconPath: "assets/icons/categories/1.png",
      title: "펀딩+",
    ),
    const ProjectCategory(
      id: 5,
      iconPath: "assets/icons/categories/5.png",
      title: "혜택",
    ),
    const ProjectCategory(
      id: 2,
      iconPath: "assets/icons/categories/2.png",
      title: "오픈예정",
    ),
    const ProjectCategory(
      id: 6,
      iconPath: "assets/icons/categories/6.png",
      title: "펀딩체험단",
    ),
    const ProjectCategory(
      id: 3,
      iconPath: "assets/icons/categories/3.png",
      title: "스토어",
    ),
    const ProjectCategory(
      id: 7,
      iconPath: "assets/icons/categories/7.png",
      title: "뷰티워크",
    ),
    const ProjectCategory(
      id: 4,
      iconPath: "assets/icons/categories/4.png",
      title: "예약구매",
    ),
    const ProjectCategory(
      id: 8,
      iconPath: "assets/icons/categories/8.png",
      title: "새학기출발",
    ),
    const ProjectCategory(
      id: 5,
      iconPath: "assets/icons/categories/5.png",
      title: "혜택",
    ),
    const ProjectCategory(
      id: 9,
      iconPath: "assets/icons/categories/9.png",
      title: "클래스수강",
    ),
  ];
  return categorys;
}
