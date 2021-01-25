import 'package:animalstat_repository/animalstat_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = AnimalstatBlocObserver();

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
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return const Center(
            child: Text(
              'Error initializing Firebase.',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return _buildMainApp(context);
        }

        return const CircularProgressIndicator();
      },
    );
  }

  Widget _buildMainApp(BuildContext context) {
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
                  create: RepositoryFactory.createDiagnosisRepository,
                ),
                RepositoryProvider(
                  create: RepositoryFactory.createRecurringTreatmentsRepository,
                ),
                RepositoryProvider(
                  create: RepositoryFactory.createTreatmentRepository,
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
