import 'package:animal_stat/app/login/login_screen.dart';
import 'package:animal_stat/app/search_animal/search_animal_screen.dart';
import 'package:animal_stat/app/splash/splash_screen.dart';
import 'package:animal_stat/src/bloc_providers.dart';
import 'package:animal_stat/src/repository_providers.dart';
import 'package:bloc/bloc.dart';
import 'package:animal_stat/app/authentication/bloc/bloc.dart';
import 'package:animal_stat/app/user/user_repository.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'simple_bloc_delegate.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  // Set `enableInDevMode` to true to see reports while in debug mode
  // This is only to be used for confirming that reports are being
  // submitted as expected. It is not intended to be used for everyday
  // development.
  Crashlytics.instance.enableInDevMode = false;

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  runApp(
    MultiRepositoryProvider(
      providers: RepositoryProviders.providers,
      child: MultiBlocProvider(
        providers: BlocProviders.providers,
        child: App(),
      ),
    ),
  );
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        disabledColor: Colors.green[200],
        primarySwatch: Colors.green,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (BuildContext context, AuthenticationState state) {
        if (state is Uninitialized) {
          return SplashScreen();
        }

        if (state is Unauthenticated) {
          return LoginScreen(
            userRepository: RepositoryProvider.of<UserRepository>(context),
          );
        }

        if (state is Authenticated) {
          return SearchAnimalScreen(
            name: state.displayName,
          );
        }

        return Container();
      }),
    );
  }
}
