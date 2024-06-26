import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/utils/helper_functions.dart';
import '../../../models/app_user.dart';
import '../../api_services/auth_service.dart';
import '../../app_config.dart';
import '../../core/base_bloc/base_bloc.dart';
import '../../core/preference_client/preference_client.dart';
import '../../core/utils/utils.dart';
import '../../models/token.dart';
import '../../views/auth/login_page.dart';
import '../../views/global_widgets/toast_helper.dart';
import '../../views/home/home_page.dart';
import '../app_bloc/app_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends BaseBloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  final AuthService authService = AuthService();

  LoginWithMicrosoftSuccess loginWithPasswordSuccess = LoginWithMicrosoftSuccess();
  CheckForPreferenceSuccess checkForPreferenceSuccess = CheckForPreferenceSuccess();

  FutureOr<void> _checkForPreference(
      CheckForPreference event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final AppUser? user = await PreferencesClient(prefs: prefs).getUser();
    emit(checkForPreferenceSuccess..user = user);
  }

  FutureOr<void> _loginWithMicrosoft(
      LoginWithMicrosoft event, Emitter<AuthState> emit) async {
      emit(AuthLoading());
      final OAuthProvider provider = OAuthProvider('microsoft.com');
      provider.setCustomParameters(<String, String>{
        'tenant': AppConfig.shared.msTenantID,
      });
      await FirebaseAuth.instance.signInWithPopup(provider);
      final User? user = FirebaseAuth.instance.currentUser;
      final String? idToken = await user?.getIdToken();
      debugPrint('access Token: $idToken');
      final Map<String, dynamic> headersToApi = await Utils.getHeader(idToken);
      final AppUser userResponse =
      await authService.loginWithMicrosoft(headersToApi: headersToApi);
      final Token token = Token(accessToken: idToken);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      PreferencesClient(prefs: prefs).saveUser(appUser: userResponse);
      PreferencesClient(prefs: prefs).setUserAccessToken(token: token);
      emit(loginWithPasswordSuccess..user = userResponse);
  }

  FutureOr<void> _logOut(LogOut event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await FirebaseAuth.instance.signOut();
    PreferencesClient(prefs: prefs).saveUser();
    emit(LogOutSuccess());
  }

  @override
  Future<void> eventHandlerMethod(AuthEvent event, Emitter<AuthState> emit) async {
    switch (event.runtimeType) {
      case const (CheckForPreference):
        return _checkForPreference(event as CheckForPreference, emit);
      case const (LoginWithMicrosoft):
        return _loginWithMicrosoft(event as LoginWithMicrosoft, emit);
      case const (LogOut):
        return _logOut(event as LogOut, emit);
    }
  }

  @override
  AuthState getErrorState() {
    return AuthError();
  }
}

Future<void> onAuthBlocChange(
    {required BuildContext context,
    required AuthState state,
    required AppBloc appBloc}) async {
  switch (state.runtimeType) {
    case const (LogOutSuccess):
      Navigator.pushReplacement(
          context,
          MaterialPageRoute<dynamic>(
            builder: (_) => const LoginPage(),
          ));

    case const (LoginWithMicrosoftSuccess):
      final LoginWithMicrosoftSuccess currentState =
          state as LoginWithMicrosoftSuccess;
      appBloc.add(SaveCurrentUser(user: currentState.user));
      Navigator.pushReplacement(
          context,
          MaterialPageRoute<dynamic>(
            builder: (_) => const HomePage(),
          ));

    case const (AuthError):
      final AuthError currentState = state as AuthError;
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
