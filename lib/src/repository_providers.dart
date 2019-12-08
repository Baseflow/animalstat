import 'package:livestock_repository/livestock_repository.dart';
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
