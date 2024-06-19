import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/utils/helper_functions.dart';
import '../../api_services/projects_service.dart';
import '../../core/base_bloc/base_bloc.dart';
import '../../core/preference_client/preference_client.dart';
import '../../core/utils/utils.dart';
import '../../models/app_user.dart';
import '../../models/project.dart';
import '../../models/task.dart';
import '../../models/token.dart';
import '../../views/global_widgets/toast_helper.dart';
import '../../views/tasks/tasks_page.dart';

part 'projects_event.dart';

part 'projects_state.dart';

class ProjectsBloc extends BaseBloc<ProjectsEvent, ProjectsState> {
  ProjectsBloc() : super(ProjectsInitial());

  final ProjectsService projectsService = ProjectsService();

  GetProjectsSuccess getProjectsSuccess = GetProjectsSuccess();
  GetProjectTasksSuccess getProjectTasksSuccess = GetProjectTasksSuccess();

  FutureOr<void> _getProjects(
      GetProjects event, Emitter<ProjectsState> emit) async {
    emit(ProjectsLoading());
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final Token? token =
        await PreferencesClient(prefs: prefs).getUserAccessToken();
    final Map<String, dynamic> headersToApi =
        await Utils.getHeader(token?.accessToken);
    final AppUser user =
    await projectsService.getProjects(headersToApi: headersToApi);
    emit(getProjectsSuccess..projects = user.workingProjects);
  }

  FutureOr<void> _getProjectTasks(
      GetProjectTasks event, Emitter<ProjectsState> emit) async {
    emit(ProjectsLoading());
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final Token? token =
        await PreferencesClient(prefs: prefs).getUserAccessToken();
    final Map<String, dynamic> headersToApi =
        await Utils.getHeader(token?.accessToken);
    final Map<String, dynamic> queryParams = <String, dynamic>{
      'project_id': event.project?.id
    };
      final List<Task> tasks =
      await projectsService.getProjectTasks(headersToApi: headersToApi, queryParams: queryParams);
    emit(getProjectTasksSuccess
      ..tasks = tasks
      ..project = event.project);
  }

  @override
  Future<void> eventHandlerMethod(
      ProjectsEvent event, Emitter<ProjectsState> emit) async {
    switch (event.runtimeType) {
      case const (GetProjects):
        return _getProjects(event as GetProjects, emit);
      case const (GetProjectTasks):
        return _getProjectTasks(event as GetProjectTasks, emit);
    }
  }

  @override
  ProjectsState getErrorState() {
    return ProjectsError();
  }
}

Future<void> onProjectsBlocChange(
    {required BuildContext context, required ProjectsState state}) async {
  switch (state.runtimeType) {
    case const (GetProjectTasksSuccess):
      final GetProjectTasksSuccess currentState =
          state as GetProjectTasksSuccess;
      Navigator.push(
          context,
          MaterialPageRoute<dynamic>(
            builder: (_) => TasksPage(
                title: currentState.project?.projectName ?? '',
                isProject: true,
                tasks: currentState.tasks),
          ));
    case const (ProjectsError):
      final ProjectsError currentState = state as ProjectsError;
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
