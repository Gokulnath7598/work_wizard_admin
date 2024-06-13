part of 'auth_bloc.dart';

abstract class AuthState extends ErrorState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {}

class LogOutSuccess extends AuthState {}

class CheckForPreferenceSuccess extends AuthState {
  CheckForPreferenceSuccess({this.user});

  AppUser? user;
}

class LoginWithMicrosoftSuccess extends AuthState {
  LoginWithMicrosoftSuccess({this.user});

  AppUser? user;
}
