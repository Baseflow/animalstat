import 'package:animalstat_repository/animalstat_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './app/authentication/bloc/bloc.dart';
import './app/login/login_screen.dart';
import './app/splash/splash_screen.dart';
import './src/animalstat_bloc_observer.dart';
import './src/bloc_providers.dart';
import './src/factories/repository_factory.dart';
import './src/providers/multi_utility_provider.dart';
import './src/ui/theming.dart';
import './src/utility_providers.dart';
import 'app/app_screen.dart';

void main() {
  Bloc.observer = AnimalstatBlocObserver();

  // Set `enableInDevMode` to true to see reports while in debug mode
  // This is only to be used for confirming that reports are being
  // submitted as expected. It is not intended to be used for everyday
  // development.
  Crashlytics.instance.enableInDevMode = false;

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  runApp(
    MultiUtilityProvider(
      providers: utilityProviders,
      child: RepositoryProvider<UserRepository>(
        create: (context) => FirestoreUserRepository(),
        child: MultiBlocProvider(
          providers: blocProviders,
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
    return GestureDetector(
      onTap: () {
        final currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp(
        theme: getTheme(context),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
          if (state is Uninitialized) {
            return SplashScreen();
          }

          if (state is Unauthenticated) {
            return LoginScreen();
          }

          if (state is Authenticated) {
            return MultiRepositoryProvider(
              providers: [
                RepositoryProvider(
                  create: RepositoryFactory.createAnimalRepository,
                ),
                RepositoryProvider(
                  create: RepositoryFactory.createRecurringTreatmentsRepository,
                ),
              ],
              child: AppScreen(),
            );
          }

          return Container();
        }),
      ),
    );
  }
}
