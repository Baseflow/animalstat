import 'package:animal_stat/app/authentication/bloc/bloc.dart';
import 'package:animal_stat/app/user/user_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocProviders {
  static List<BlocProvider> get providers => [
        BlocProvider<AuthenticationBloc>(
          builder: (BuildContext context) => AuthenticationBloc(
            userRepository: RepositoryProvider.of<UserRepository>(context),
          )..dispatch(AppStarted()),
        ),
      ];
}
