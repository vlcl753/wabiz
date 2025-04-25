import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/entity/home/home_entity.dart';
import '../../../domain/repository/home/home_repository.dart';
import '../../data_source/home/home_api.dart';
import '../../data_source/home/home_api_service.dart';

part 'home_repository_impl.g.dart';
/**
    Repository에서는 Service에 있는 메서드를 사용하기 위해 Service를 주입받는다.
    그리고 전역으로 해당 Repository에 접근하기 위해서는 Provider를 생성한다.
    이때 Repository에 필요한 Service는 ref통해 전역으로 접근해서 주입 시킨다.
 */

class HomeRepositoryImpl extends HomeRepository {
  HomeApi homeApiService;

  HomeRepositoryImpl(this.homeApiService);



  @override
  Future<List<HomeEntity>> getHomeProject() async {
    final result = await homeApiService.getHomeProjects();
    return result.projects.map((e) => HomeEntity.fromModel(e)).toList();
  }
}

@riverpod
HomeRepositoryImpl homeRepository(Ref ref) {
  final homeApiService = ref.watch(homeApiServiceProvider);
  return HomeRepositoryImpl(homeApiService);
}
