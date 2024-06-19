import 'dart:async';
import 'package:dio/dio.dart';
import '../core/api_repository/api_repository.dart';
import '../models/employee.dart';
import '../models/task.dart';

class EmployeeService extends ApiRepository {

//************************************ get Employee *********************************//
  Future<List<Employee>> getEmployee(
      {Map<String, dynamic>? headersToApi}) async {
    final Response<dynamic> res = await ApiRepository.apiClient.get(
      '/admin/users',
        options: Options(headers: headersToApi)
    );
    return (res.data['users'] as List<dynamic>).map((dynamic e) => Employee.fromJson(e as Map<String, dynamic>)).toList();
  }

//************************************ get EmployeeTasks *********************************//
  Future<List<Task>> getEmployeeTasks(
      {Map<String, dynamic>? headersToApi, Map<String, dynamic>? queryParams}) async {
    final Response<dynamic> res = await ApiRepository.apiClient.get(
      '/admin/tasks',
      queryParameters: queryParams,
      options: Options(headers: headersToApi)
    );
    return (res.data['tasks'] as List<dynamic>).map((dynamic e) => Task.fromJson(e as Map<String, dynamic>)).toList();
  }
}
