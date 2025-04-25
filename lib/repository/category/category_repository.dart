import 'package:fastcampus_wabiz_client/service/category/category_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../model/category/category_model.dart';
import '../../service/category/category_api_service.dart';
import '../../shared/model/project_type.dart';

part 'category_repository.g.dart';

@riverpod
CategoryRepository categoryRepository(Ref ref) {
  final service = ref.watch(categoryApiServiceProvider);
  return CategoryRepository(service);
}

class CategoryRepository {
  CategoryApiClient categoryApiClient;

  CategoryRepository(this.categoryApiClient);

  List<ProjectType> getProjectType() {
    List<ProjectType> defaultTypes = [

      const ProjectType(
          id: 1, type: "테크가전", imagePath: "assets/icons/type/1.svg"),
      const ProjectType(
          id: 2, type: "패션", imagePath: "assets/icons/type/2.svg"),
      const ProjectType(
          id: 3, type: "뷰티", imagePath: "assets/icons/type/3.svg"),
      const ProjectType(
          id: 4, type: "출릴병", imagePath: "assets/icons/type/4.svg"),
      const ProjectType(
          id: 5, type: "스포츠와웃도어", imagePath: "assets/icons/type/5.svg"),
      const ProjectType(
          id: 6, type: "푸드", imagePath: "assets/icons/type/6.svg"),
      const ProjectType(
          id: 7, type: "도서전자책", imagePath: "assets/icons/type/7.svg"),
      const ProjectType(
          id: 8, type: "클래스", imagePath: "assets/icons/type/8.svg"),
    ];
    return [
    const ProjectType(id: 0, type: "전체", imagePath: "assets/icons/type/all.svg")
    ,
    const ProjectType(id: 0, type: "BEST 펀딩", imagePath: "assets/icons/type/best.svg"),
    ...
    defaultTypes
    ];
  }

  Future<CategoryModel> getCategoryProjects(String? categoryId,
      String typeId) async {
    final result = await categoryApiClient.getProjectsByProjectsType(
        categoryId, typeId);
    return result;
  }

  Future<CategoryModel> getProjectsByCategoryId(String? categoryId) async {
    final result = await categoryApiClient.getProjectsByCategoryId(categoryId);
    return result;
  }
}
