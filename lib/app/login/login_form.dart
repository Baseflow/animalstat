import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../src/ui/widgets/animalstat_primary_button.dart';
import '../../src/ui/widgets/animalstat_secondary_button.dart';
import '../../src/ui/widgets/animalstat_text_form_field.dart';
import '../authentication/bloc/bloc.dart';
import 'bloc/bloc.dart';

class LoginForm extends StatefulWidget {
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();

    _loginBloc = context.read<LoginBloc>();
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Login Failure'),
                    const Icon(Icons.error),
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }

        if (state.isSubmitting) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Logging In...'),
                    const CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }

        if (state.isSuccess) {
          context.read<AuthenticationBloc>().add(LoggedIn());
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: Center(
                      child: Image.asset(
                        'assets/images/animalstat_banner.png',
                      ),
                    ),
                  ),
                  AnimalstatTextFormField(
                    controller: _emailController,
                    prefixIcon: const Icon(Icons.email),
                    labelText: 'Email',
                    autovalidateMode: AutovalidateMode.always,
                    autocorrect: false,
                    validator: (_) {
                      return !state.isEmailValid ? 'Invalid Email' : null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: AnimalstatTextFormField(
                      controller: _passwordController,
                      prefixIcon: const Icon(Icons.lock),
                      labelText: 'Password',
                      obscureText: true,
                      autovalidateMode: AutovalidateMode.always,
                      autocorrect: false,
                      validator: (_) {
                        return !state.isPasswordValid
                            ? 'Invalid Password'
                            : null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        AnimalstatPrimaryButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _submitForm();
                              }
                            },
                            text: 'Login'),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: AnimalstatSecondaryButton(
                            onPressed: () {},
                            text: 'Forgot password',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _loginBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _loginBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _submitForm() {
    _loginBloc.add(
      LoginWithCredentialsPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}
