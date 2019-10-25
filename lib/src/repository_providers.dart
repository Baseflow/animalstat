import 'package:livestock/app/user/user_repository.dart';
import 'package:livestock/src/repositories/firebase_user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RepositoryProviders {
  static List<RepositoryProvider> get providers => [
        RepositoryProvider<UserRepository>(
          builder: (context) => FirebaseUserRepository(),
        )
      ];
}
