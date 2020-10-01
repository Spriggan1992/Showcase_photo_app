part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends LoginEvent {
  final String email;

  const EmailChanged({this.email});
  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChanged { email: $email }';
}

class PasswordChanged extends LoginEvent {
  final String password;

  const PasswordChanged({this.password});
  @override
  List<Object> get props => [password];

  @override
  String toString() => 'EmailChanged { password: $password }';
}

class NicknameChanged extends LoginEvent {
  final String nickname;

  const NicknameChanged({this.nickname});
  @override
  List<Object> get props => [nickname];

  @override
  String toString() => 'EmailChanged { nickname: $nickname }';
}

class LoginPressed extends LoginEvent {
  final String email;
  final String password;

  const LoginPressed({
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [email, password];

  @override
  String toString() => 'LoginPressed { email: $email, password: $password }';
}

class SignupPressed extends LoginEvent {
  final String email;
  final String password;
  final String nickname;

  const SignupPressed({
    @required this.email,
    @required this.password,
    @required this.nickname,
  });

  @override
  List<Object> get props => [email, password, nickname];

  @override
  String toString() =>
      'SignupPressed { email: $email, password: $password, nickname: $nickname}';
}
