import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/repository/home/home_repository_impl.dart';
import '../../../views/home/home_page.dart';
import '../../entity/home/home_entity.dart';

part 'fetch_home_projects.g.dart';

@riverpod
Future<List<HomeEntity>> fetchHomeProject(FetchHomeProjectRef ref) async {
  try {
    final result = await ref.watch(homeRepositoryProvider).getHomeProject();
    return result;
  } on DioException catch (error) {
    switch (error.type) {
      case DioExceptionType.connectionError:
        throw ConnectionError(error);
      case DioExceptionType.connectionTimeout:
        throw ConnectionTimeoutError(error);
      default:
    }
    return [];
  }
}
