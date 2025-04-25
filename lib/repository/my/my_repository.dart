import 'package:fastcampus_wabiz_client/service/project/project_api.dart';
import 'package:fastcampus_wabiz_client/shared/model/response_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../model/project/project_model.dart';
import '../../service/project/project_api_service.dart';

part 'my_repository.g.dart';
@riverpod
MyRepository myRepository (Ref ref) {
  final service=ref.watch(projectApiServiceProvider);
  return MyRepositoryImpl(service);
}

abstract class MyRepository{
  Future getProjectsByUserId(String userId);

  Future updateProjectOpenState(String id, ProjectItemModel body);

  Future deleteProject(String id);
}

class MyRepositoryImpl implements MyRepository{

  ProjectApiClient projectService;

  MyRepositoryImpl(this.projectService);

  @override
  Future<ResponseModel> deleteProject(String id) async{
    final result = await projectService.deleteProject(id);
    return result;
  }

  @override
  Future<ProjectModel> getProjectsByUserId(String userId) async{
    return await projectService.getProjectByUserId(userId);
  }

  @override
  Future<ResponseModel> updateProjectOpenState(String id, ProjectItemModel body) async{
    final result = await projectService.updateProjectOpenState(id, body);
    return result;
  }

}