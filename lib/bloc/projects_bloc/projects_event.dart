part of 'projects_bloc.dart';

@immutable
abstract class ProjectsEvent {}

class GetProjects extends ProjectsEvent {}

class GetProjectTasks extends ProjectsEvent {
  GetProjectTasks({this.project});
  final Project? project;
}
