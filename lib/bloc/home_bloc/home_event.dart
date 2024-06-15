part of 'home_bloc.dart';


@immutable
abstract class HomeEvent {}

class GetAllProjects extends HomeEvent {}

class GetProfile extends HomeEvent {}

class UpdateProfile extends HomeEvent {
  UpdateProfile({this.projectIDs});
  final List<int>? projectIDs;
}
