part of 'home_bloc.dart';

abstract class HomeState extends ErrorState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {}

class GetProfileSuccess extends HomeState {
  GetProfileSuccess({this.user});

  AppUser? user;
}

class UpdateProfileSuccess extends HomeState {
  UpdateProfileSuccess({this.user});

  AppUser? user;
}

class GetAllProjectsSuccess extends HomeState {
  GetAllProjectsSuccess({this.allProject});

  List<Project>? allProject;
}
