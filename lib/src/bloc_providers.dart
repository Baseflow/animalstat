import 'package:livestock/app/authentication/bloc/bloc.dart';
import 'package:livestock/app/login/bloc/bloc.dart';
import 'package:livestock/app/login/bloc/login_bloc.dart';
import 'package:livestock/src/providers/utility_provider.dart';
import 'package:livestock/src/utilities/utilities.dart';
import 'package:livestock_repository/livestock_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocProviders {
  static List<BlocProvider> get providers => [
        BlocProvider<AuthenticationBloc>(
          create: (BuildContext context) => AuthenticationBloc(
            userRepository: RepositoryProvider.of<UserRepository>(context),
          )..add(AppStarted()),
        ),
        BlocProvider<LoginBloc>(
          create: (BuildContext context) => LoginBloc(
            userRepository: RepositoryProvider.of<UserRepository>(context),
            validators: UtilityProvider.of<Validators>(context),
          ),
        ),
      ];
}
