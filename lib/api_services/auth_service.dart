import 'dart:async';
import 'package:dio/dio.dart';
import '../core/api_repository/api_repository.dart';
import '../models/app_user.dart';

class AuthService extends ApiRepository {

//************************************ log-in *********************************//
  Future<AppUser> loginWithMicrosoft(
      {Map<String, dynamic>? headersToApi}) async {
    final Response<dynamic> res = await ApiRepository.apiClient.get(
      '/user/users',
      options: Options(
        headers: headersToApi)
    );
    return AppUser.fromJson(res.data['user'] as Map<String, dynamic>);
  }

//************************************ log-out *********************************//
  Future<Response<dynamic>> logOut(
      {Map<String, dynamic>? headersToApi}) async {
    final Response<dynamic> res = await ApiRepository.apiClient.delete(
      '/user_management/logout',
      options: Options(headers: headersToApi)
    );
    return res;
  }
}
