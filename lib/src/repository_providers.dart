import 'package:animal_stat/app/user/user_repository.dart';
import 'package:animal_stat/src/repositories/firebase_user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RepositoryProviders {
  static List<RepositoryProvider> get providers => [
        RepositoryProvider<UserRepository>(
          builder: (context) => FirebaseUserRepository(),
        )
      ];
}
