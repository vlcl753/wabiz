import 'package:fastcampus_wabiz_client/service/home/home_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../model/home/home_model.dart';
import '../../service/home/home_api_service.dart';

part 'home_repository.g.dart';

class HomeRepository {
  HomeApi homeApiService;

  HomeRepository(this.homeApiService);

  Future<HomeModel> getHomeProject() async {
    final result = await homeApiService.getHomeProject();
    return result;
  }
}

@riverpod
HomeRepository homeRepository (Ref ref){
  final homeApiService = ref.watch(homeApiServiceProvider);
  return HomeRepository(homeApiService);
}