import 'package:animalstat_repository/animalstat_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app/authentication/bloc/bloc.dart';
import '../app/bottom_navigation/bloc/bottom_navigation_bloc.dart';
import '../app/login/bloc/bloc.dart';
import '../app/login/bloc/login_bloc.dart';
import 'providers/utility_provider.dart';
import 'utilities/utilities.dart';

List<BlocProvider> get blocProviders => [
      BlocProvider<AuthenticationBloc>(
        create: (context) => AuthenticationBloc(
          userRepository: RepositoryProvider.of<UserRepository>(context),
        )..add(AppStarted()),
      ),
      BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(
          userRepository: RepositoryProvider.of<UserRepository>(context),
          validators: UtilityProvider.of<Validators>(context),
        ),
      ),
      BlocProvider<BottomNavigationBloc>(
        create: (_) => BottomNavigationBloc(),
      ),
    ];
