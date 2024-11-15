import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../config/service_locator/service_locator.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/use_cases/auth/auth_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthInitial());

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();

  Future<void> logIn(void Function() callback) async {
    var userEntity = UserEntity(
      username: usernameController.text,
      password: passwordController.text,
    );
    var authService = serviceLocator.get<AuthService>();
    if (await authService.logIn(
      userEntity,
    )) {
      authService.set(userEntity);
      callback.call();
      emit(const AuthInitial());
      return;
    }
    emit(state.copyWith(isValidPassword: false)); //todo: show auth error
  }

  void validatePassword(void Function() callback) {
    passwordController.text != repeatPasswordController.text
        ? emit(state.copyWith(isValidPassword: false))
        : signUp(callback);
  }

  Future<void> signUp(void Function() callback) async {
    var authService = serviceLocator.get<AuthService>();
    var userEntity = UserEntity(
      username: usernameController.text,
      password: passwordController.text,
    );
    if (await authService.signUp(
      userEntity,
    )) {
      authService.set(userEntity);
      callback.call();
      emit(const AuthInitial());
      return;
    }
    emit(state.copyWith(isValidPassword: false));
  }

  void validateTextFormFields(String value) {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      emit(state.copyWith(enableSubmitButton: false));
      return;
    }

    if (!(state as AuthInitial).isSignInPage &&
        repeatPasswordController.text.isEmpty) {
      emit(state.copyWith(enableSubmitButton: false));
      return;
    }

    emit(state.copyWith(enableSubmitButton: true));
  }

  void changePage() {
    usernameController.text = '';
    passwordController.text = '';
    repeatPasswordController.text = '';

    emit(
      state.copyWith(
        isSignInPage: !(state as AuthInitial).isSignInPage,
        isValidPassword: true,
      ),
    );
  }

  void changePasswordVisibility() {
    debugPrint('${!(state as AuthInitial).showPassword}');
    emit(state.copyWith(showPassword: !(state as AuthInitial).showPassword));
  }

  void logOut() {
    serviceLocator.get<AuthService>().logOut();
    emit(state.copyWith());
  }
}
