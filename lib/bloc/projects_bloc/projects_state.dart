part of 'projects_bloc.dart';

abstract class ProjectsState extends ErrorState {}

class ProjectsInitial extends ProjectsState {}

class ProjectsLoading extends ProjectsState {}

class ProjectsError extends ProjectsState {}

class GetProjectsSuccess extends ProjectsState {
  GetProjectsSuccess({this.projects});

  List<Project>? projects;
}

class GetProjectTasksSuccess extends ProjectsState {
  GetProjectTasksSuccess({this.tasks, this.project});

  List<ProjectTask>? tasks;
  Project? project;
}
