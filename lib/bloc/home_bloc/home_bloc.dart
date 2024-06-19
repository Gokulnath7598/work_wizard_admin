import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/utils/helper_functions.dart';
import '../../api_services/home_service.dart';
import '../../core/base_bloc/base_bloc.dart';
import '../../core/preference_client/preference_client.dart';
import '../../core/utils/utils.dart';
import '../../models/app_user.dart';
import '../../models/project.dart';
import '../../models/token.dart';
import '../../views/global_widgets/toast_helper.dart';
import '../app_bloc/app_bloc.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial());

  final HomeService homeService = HomeService();

  GetProfileSuccess getProfileSuccess = GetProfileSuccess();
  UpdateProfileSuccess updateProfileSuccess = UpdateProfileSuccess();
  GetAllProjectsSuccess getAllProjectsSuccess = GetAllProjectsSuccess();


  FutureOr<void> _getAllProjects(
      GetAllProjects event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final Token? token =
    await PreferencesClient(prefs: prefs).getUserAccessToken();
    final Map<String, dynamic> headersToApi =
    await Utils.getHeader(token?.accessToken);

    final List<Project> allProject =
    await homeService.getAllProjects(headersToApi: headersToApi);
    emit(getAllProjectsSuccess..allProject = allProject);
  }

  FutureOr<void> _getProfile(
      GetProfile event, Emitter<HomeState> emit) async {
    emit(HomeLoading());


    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final Token? token =
    await PreferencesClient(prefs: prefs).getUserAccessToken();
    final Map<String, dynamic> headersToApi =
    await Utils.getHeader(token?.accessToken);
    final AppUser user =
    await homeService.getProfile(headersToApi: headersToApi);
    PreferencesClient(prefs: prefs).saveUser(appUser: user);
    emit(getProfileSuccess..user = user);
  }

  FutureOr<void> _updateProfile(
      UpdateProfile event, Emitter<HomeState> emit) async {
    emit(HomeLoading());

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final Token? token =
    await PreferencesClient(prefs: prefs).getUserAccessToken();
    final Map<String, dynamic> headersToApi =
    await Utils.getHeader(token?.accessToken);
    final Map<String, dynamic> objToApi =
    <String, dynamic>{
      'user': <String, List<int>?>{
        'working_project_ids': event.projectIDs}
    };

    final AppUser user =
    await homeService.updateProfile(headersToApi: headersToApi, objToApi: objToApi);
    PreferencesClient(prefs: prefs).saveUser(appUser: user);
    emit(updateProfileSuccess..user = user);
  }

  @override
  Future<void> eventHandlerMethod(
      HomeEvent event, Emitter<HomeState> emit) async {
    switch (event.runtimeType) {
      case const (GetAllProjects):
        return _getAllProjects(event as GetAllProjects, emit);
      case const (GetProfile):
        return _getProfile(event as GetProfile, emit);
      case const (UpdateProfile):
        return _updateProfile(event as UpdateProfile, emit);
    }
  }

  @override
  HomeState getErrorState() {
    return HomeError();
  }
}

Future<void> onHomeBlocChange(
    {required BuildContext context, required HomeState state, required AppBloc appBloc}) async {
  switch (state.runtimeType) {
    case const (GetProfileSuccess):
      final GetProfileSuccess currentState =
          state as GetProfileSuccess;
      appBloc.add(SaveCurrentUser(user: currentState.user));
    case const (UpdateProfileSuccess):
      final UpdateProfileSuccess currentState =
          state as UpdateProfileSuccess;
      appBloc.add(SaveCurrentUser(user: currentState.user));
    case const (HomeError):
      final HomeError currentState = state as HomeError;
      if (currentState.forceLogOut) {
        await forceLogOut(context);
      }
      if (context.mounted) {
        ToastHelper.failureToast(
            context: context,
            message: '${currentState.errorCode} : ${currentState.errorMsg}');
      }
  }
}
