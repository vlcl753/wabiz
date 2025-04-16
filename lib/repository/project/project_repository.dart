import 'package:fastcampus_wabiz_client/service/project/project_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../model/project/project_model.dart';
import '../../model/project/reward_model.dart';
import '../../service/project/project_api_service.dart';
import '../../shared/model/response_model.dart';

part 'project_repository.g.dart';

class ProjectRepository {
  ProjectApiClient projectService;

  ProjectRepository(this.projectService);

  Future<ResponseModel?> createProject(ProjectItemModel body) async {
    final result = await projectService.createProject(body);
    return result;
  }

  Future<ResponseModel?> updateProjectOpenState(
      String id, ProjectItemModel body) async {
    final result = await projectService.updateProjectOpenState(id, body);
    return result;
  }

  Future<ResponseModel?> deleteProject(String id) async {
    final result = await projectService.deleteProject(id);
    return result;
  }

  Future<ResponseModel?> createProjectReward(
      String id, RewardItemModel body) async {
    final result = await projectService.createProjectReward(id, body);
    return result;
  }

  Future<ProjectModel> getProjectsByUserId(String userId) async {
    final result = await projectService.getProjectByUserId(userId);
    return result;
  }

  Future<ProjectModel> getProjectByProjectId(String id) async {
    final result = await projectService.getProjectByProjectId(id);
    return result;
  }
}

@riverpod
ProjectRepository projectRepository(ProjectRepositoryRef ref) {
  final service = ref.watch(projectApiServiceProvider);
  return ProjectRepository(service);
}