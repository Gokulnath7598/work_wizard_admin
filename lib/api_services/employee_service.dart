import 'dart:async';
import 'package:dio/dio.dart';
import '../core/api_repository/api_repository.dart';
import '../models/employee.dart';
import '../models/project.dart';
import '../models/task.dart';

class EmployeeService extends ApiRepository {

//************************************ get Employee *********************************//
  Future<List<Employee>> getEmployee(
      {Map<String, String>? headersToApi}) async {
    final Response<dynamic> res = await ApiRepository.apiClient.get(
      '/user_management/employee',
        options: Options(headers: headersToApi)
    );
    return (res.data['employee'] as List<dynamic>).map((dynamic e) => Employee.fromJson(e as Map<String, dynamic>)).toList();
  }

//************************************ get EmployeeTasks *********************************//
  Future<List<Task>> getEmployeeTasks(
      {Map<String, String>? headersToApi, Map<String, dynamic>? queryParams}) async {
    final Response<dynamic> res = await ApiRepository.apiClient.get(
      '/task_management/tasks',
      queryParameters: queryParams,
      options: Options(headers: headersToApi)
    );
    return (res.data['tasks'] as List<dynamic>).map((dynamic e) => Task.fromJson(e as Map<String, dynamic>)).toList();
  }
}
