import 'package:livestock/app/user/user_repository.dart';
import 'package:flutter/material.dart';

import 'login_form.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository _userRepository;

  LoginScreen({
    Key key,
    @required UserRepository userRepository,
  })  : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text('Login'),
      ),
      body: LoginForm(
        userRepository: _userRepository,
      ),
    );
  }
}
