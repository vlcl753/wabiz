import 'package:fastcampus_wabiz_client/service/home/home_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../model/home/home_model.dart';
import '../../service/home/home_api_service.dart';

part 'home_repository.g.dart';

/**
    Repository에서는 Service에 있는 메서드를 사용하기 위해 Service를 주입받는다.
    그리고 전역으로 해당 Repository에 접근하기 위해서는 Provider를 생성한다.
    이때 Repository에 필요한 Service는 ref통해 전역으로 접근해서 주입 시킨다.
 */

class HomeRepository {
  HomeApi homeApiService;

  HomeRepository(this.homeApiService);

  Future<HomeModel> getHomeProjects() async {
    final result = homeApiService.getHomeProjects();
    return result;
  }
}

@riverpod
HomeRepository homeRepository(Ref ref) {
  final homeApiService = ref.watch(homeApiServiceProvider);
  return HomeRepository(homeApiService);
}

