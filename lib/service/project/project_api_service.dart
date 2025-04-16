import 'package:fastcampus_wabiz_client/service/project/project_api.dart';
import 'package:fastcampus_wabiz_client/shared/network_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'project_api_service.g.dart';

@riverpod
ProjectApiClient projectApiService(Ref ref) {
  final dio = ref.watch(dioProvider);
  var localhost = "localhost";
  if (defaultTargetPlatform == TargetPlatform.android) {
    localhost = "10.0.2.2";
  }
  return ProjectApiClient(
    dio,
    baseUrl: "http://$localhost:3000/api/v1",
  );
}
