class Validators {
  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  static isValidEmail(String email) {
    return _emailRegex.hasMatch(email);
  }

  static isValidPassword(String password) {
    return password.length > 5;
  }

  static isValidNickname(String nickname) {
    return nickname.isNotEmpty;
  }
}
