import 'dart:async';
import 'package:dio/dio.dart';
import '../core/api_repository/api_repository.dart';
import '../models/app_user.dart';
import '../models/project.dart';

class HomeService extends ApiRepository {

//************************************ get All Projects *********************************//
  Future<List<Project>> getAllProjects(
      {Map<String, dynamic>? headersToApi}) async {
    final Response<dynamic> res = await ApiRepository.apiClient.get(
      '/user/projects',
        options: Options(headers: headersToApi)
    );
    return (res.data['projects'] as List<dynamic>).map((dynamic e) => Project.fromJson(e as Map<String, dynamic>)).toList();
  }

//************************************ get Profile *********************************//
  Future<AppUser> getProfile(
      {Map<String, dynamic>? headersToApi}) async {
    final Response<dynamic> res = await ApiRepository.apiClient.get(
      '/user/users',
      options: Options(headers: headersToApi)
    );
    return AppUser.fromJson(res.data['user'] as Map<String, dynamic>);
  }

//************************************ get ProjectTasks *********************************//
  Future<AppUser> updateProfile(
      {Map<String, dynamic>? headersToApi, Map<String, dynamic>? objToApi}) async {
    final Response<dynamic> res = await ApiRepository.apiClient.put(
      '/user/users/1',
        data: objToApi,
      options: Options(headers: headersToApi)
    );
    return AppUser.fromJson(res.data['user'] as Map<String, dynamic>);
  }
}
