import 'package:animal_repository/animal_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RepositoryProviders {
  static List<RepositoryProvider> get providers => [
        RepositoryProvider<UserRepository>(
          builder: (context) => FirebaseUserRepository(),
        ),
        RepositoryProvider<AnimalRepository>(
          builder: (context) => FirestoreAnimalRepository(),
        ),
      ];
}
