import 'dart:async';
import 'package:dio/dio.dart';
import '../core/api_repository/api_repository.dart';
import '../models/app_user.dart';
import '../models/task.dart';

class ProjectsService extends ApiRepository {

//************************************ get Projects *********************************//
  Future<AppUser> getProjects(
      {Map<String, dynamic>? headersToApi}) async {
    final Response<dynamic> res = await ApiRepository.apiClient.get(
        '/user/users',
        options: Options(headers: headersToApi)
    );
    return AppUser.fromJson(res.data['user'] as Map<String, dynamic>);
  }

//************************************ get ProjectTasks *********************************//
  Future<List<ProjectTask>> getProjectTasks(
      {Map<String, dynamic>? headersToApi, Map<String, dynamic>? queryParams}) async {
    final Response<dynamic> res = await ApiRepository.apiClient.get(
      '/admin/tasks',
      queryParameters: queryParams,
      options: Options(headers: headersToApi)
    );
    return (res.data['tasks'] as List<dynamic>).map((dynamic e) => ProjectTask.fromJson(e as Map<String, dynamic>)).toList();
  }
}
