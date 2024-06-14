import 'dart:async';
import 'package:dio/dio.dart';
import '../core/api_repository/api_repository.dart';
import '../models/project.dart';
import '../models/task.dart';

class ProjectsService extends ApiRepository {

//************************************ get Projects *********************************//
  Future<List<Project>> getProjects(
      {Map<String, String>? headersToApi}) async {
    final Response<dynamic> res = await ApiRepository.apiClient.get(
      '/project_management/projects',
        options: Options(headers: headersToApi)
    );
    return (res.data['projects'] as List<dynamic>).map((dynamic e) => Project.fromJson(e as Map<String, dynamic>)).toList();
  }

//************************************ get ProjectTasks *********************************//
  Future<List<Task>> getProjectTasks(
      {Map<String, String>? headersToApi, Map<String, dynamic>? queryParams}) async {
    final Response<dynamic> res = await ApiRepository.apiClient.delete(
      '/task_management/tasks',
      queryParameters: queryParams,
      options: Options(headers: headersToApi)
    );
    return (res.data['tasks'] as List<dynamic>).map((dynamic e) => Task.fromJson(e as Map<String, dynamic>)).toList();
  }
}
