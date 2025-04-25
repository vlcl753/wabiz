import 'package:fastcampus_wabiz_client/domain/entity/home/home_entity.dart';

abstract class HomeRepository {
  Future<List<HomeEntity>> getHomeProject();
}