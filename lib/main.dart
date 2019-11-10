import 'package:flutter/services.dart';
import 'package:livestock/app/login/login_screen.dart';
import 'package:livestock/app/home/home_screen.dart';
import 'package:livestock/app/splash/splash_screen.dart';
import 'package:livestock/src/ui/theming.dart';
import 'package:livestock/src/bloc_providers.dart';
import 'package:livestock/src/providers/multi_utility_provider.dart';
import 'package:livestock/src/repository_providers.dart';
import 'package:livestock/src/utility_providers.dart';
import 'package:livestock/app/authentication/bloc/bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/livestock_bloc_delegate.dart';

void main() {
  BlocSupervisor.delegate = LivestockBlocDelegate();

  // Set `enableInDevMode` to true to see reports while in debug mode
  // This is only to be used for confirming that reports are being
  // submitted as expected. It is not intended to be used for everyday
  // development.
  Crashlytics.instance.enableInDevMode = false;

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  runApp(
    MultiUtilityProvider(
      providers: UtilityProviders.providers,
      child: MultiRepositoryProvider(
        providers: RepositoryProviders.providers,
        child: MultiBlocProvider(
          providers: BlocProviders.providers,
          child: App(),
        ),
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
        fontFamily: 'SF Pro Text',
        primaryColor: kPrimaryColor,
        accentColor: kAccentColor,
        backgroundColor: kBackgroundColor,
        scaffoldBackgroundColor: kBackgroundColor,
        dialogBackgroundColor: kWhite,
        primaryTextTheme: TextTheme(
          title: TextStyle(color: kWhite),
        ),
        textTheme: TextTheme(
          body1: TextStyle(
            color: kDefaultTextColor,
          ),
        ),
        primaryIconTheme: const IconThemeData.fallback().copyWith(
          color: Colors.white,
        ),
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
          return HomeScreen();
        }

        return Container();
      }),
    );
  }
}
