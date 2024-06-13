part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class CheckForPreference extends AuthEvent {}

class LoginWithMicrosoft extends AuthEvent {}

class LogOut extends AuthEvent {

}
