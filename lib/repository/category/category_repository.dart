import 'package:fastcampus_wabiz_client/service/category/category_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../model/category/category_model.dart';
import '../../service/category/category_api_service.dart';

part 'category_repository.g.dart';

@riverpod
CategoryRepository categoryRepository(Ref ref) {
  final service = ref.watch(categoryApiServiceProvider);
  return CategoryRepository(service);
}

class CategoryRepository {
  CategoryApiClient categoryApiClient;

  CategoryRepository(this.categoryApiClient);

  Future<CategoryModel> getCategoryProjects(String? categoryId, String typeId) async {
    final result = await categoryApiClient.getProjectsByProjectsType(categoryId, typeId);
    return result;
  }
  Future<CategoryModel> getProjectsByCategoryId(String? categoryId) async {
    final result = await categoryApiClient.getProjectsByCategoryId(categoryId);
    return result;
  }
}
