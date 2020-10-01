import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:photo/model/model.dart';
import 'package:photo/repositories/auth/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({AuthRepository authRepository})
      : _authRepository = authRepository,
        super(Unauthenticated());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is Login) {
      yield* _mapLoginToState();
    } else if (event is Logout) {
      yield* _mapLogoutToState();
    }
  }

  Stream<AuthState> _mapAppStartedToState() async* {
    try {
      User currentUser = await _authRepository.getCurrentUser();
      if (currentUser == null) {
        yield Authenticated(currentUser);
      }
    } catch (e) {
      print(e);
      yield Unauthenticated();
    }
  }

  Stream<AuthState> _mapLoginToState() async* {
    try {
      User currentUser = await _authRepository.getCurrentUser();
      yield Authenticated(currentUser);
    } catch (e) {
      print(e);
      yield Unauthenticated();
    }
  }

  Stream<AuthState> _mapLogoutToState() async* {
    try {
      await _authRepository.logout();
      yield* _mapAppStartedToState();
    } catch (e) {
      print(e);
      yield Unauthenticated();
    }
  }
}
