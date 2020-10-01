import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo/helpers/validators.dart';
import 'package:photo/repositories/repositories.dart';

import '../blocks.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthBloc _authBloc;
  AuthRepository _authRepository;

  LoginBloc(AuthBloc authBloc, AuthRepository authRepository)
      : super(LoginState.empty());
  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event);
    } else if (event is NicknameChanged) {
      yield* _mapNicknameChangedToState(event);
    } else if (event is LoginPressed) {
      yield* _mapLoginPressedToState(event);
    } else if (event is SignupPressed) {
      yield* _mapSignupPressedToState(event);
    }
  }

  Stream<LoginState> _mapEmailChangedToState(EmailChanged event) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(event.email));
  }

  Stream<LoginState> _mapPasswordChangedToState(PasswordChanged event) async* {
    yield state.update(
        isPasswordValid: Validators.isValidPassword(event.password));
  }

  Stream<LoginState> _mapNicknameChangedToState(NicknameChanged event) async* {
    yield state.update(
        isNicknameValid: Validators.isValidNickname(event.nickname));
  }

  Stream<LoginState> _mapLoginPressedToState(LoginPressed event) async* {
    yield LoginState.loading();
    try {
      await _authRepository.loginWithEmailAndPassword(
          email: event.email, password: event.password);
      _authBloc.add(Login());
    } on PlatformException catch (e) {
      yield LoginState.failure(e.message);
    }
  }

  Stream<LoginState> _mapSignupPressedToState(SignupPressed event) async* {
    yield LoginState.loading();
    try {
      await _authRepository.signUpWithEmailAndPassword(
          email: event.email,
          password: event.password,
          nickname: event.nickname);
      _authBloc.add(Login());
    } on PlatformException catch (e) {
      yield LoginState.failure(e.message);
    }
  }
}
