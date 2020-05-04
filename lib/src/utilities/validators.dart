class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  bool isValidEmail(String email) {
    return email.isNotEmpty && _emailRegExp.hasMatch(email);
  }

  bool isValidPassword(String password) {
    return password.isNotEmpty;
  }
}