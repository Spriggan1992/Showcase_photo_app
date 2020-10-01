part of 'login_bloc.dart';

@immutable
class LoginState {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isNicknameValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String errorMessage;

  bool get isFormValid => isEmailValid && isPasswordValid;

  LoginState(
      {this.isEmailValid,
      this.isPasswordValid,
      this.isNicknameValid,
      this.isSubmitting,
      this.isSuccess,
      this.isFailure,
      this.errorMessage});

  factory LoginState.empty() {
    return LoginState(
      isEmailValid: false,
      isPasswordValid: false,
      isNicknameValid: false,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      errorMessage: '',
    );
  }

  factory LoginState.loading() {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isNicknameValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
      errorMessage: '',
    );
  }

  factory LoginState.failure(String errorMessage) {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isNicknameValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }

  factory LoginState.success() {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isNicknameValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
      errorMessage: '',
    );
  }

  LoginState copyWith({
    bool isEmailValid,
    bool isPasswordValid,
    bool isNicknameValid,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
    String errorMessage,
  }) {
    return LoginState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isNicknameValid: isNicknameValid ?? this.isNicknameValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  LoginState update({
    bool isEmailValid,
    bool isPasswordValid,
    bool isNicknameValid,
  }) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isNicknameValid: isNicknameValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      errorMessage: '',
    );
  }

  @override
  String toString() => '''LoginState {
    isEmailValid: $isEmailValid,
    isPasswordValid: $isPasswordValid,
    isNicknameValid: $isNicknameValid,
    isSubmitting: $isSubmitting,
    isSuccess: $isSuccess,
    isFailure: $isFailure,
    errorMessage: $errorMessage
  }''';
}
