import 'package:animalstat_repository/animalstat_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/authentication/bloc/bloc.dart';

class RepositoryFactory {
  static AnimalRepository createAnimalRepository(BuildContext context) {
    var user = _getUser(context);
    return FirestoreAnimalRepository(user);
  }

  static DiagnosisRepository createDiagnosisRepository(BuildContext context) {
    var user = _getUser(context);
    return FirestoreDiagnosisRepository(user);
  }

  static RecurringTreatmentsRepository createRecurringTreatmentsRepository(
      BuildContext context) {
    var user = _getUser(context);
    return FirestoreRecurringTreatmentsRepository(user);
  }

  static TreatmentRepository createTreatmentRepository(BuildContext context) {
    var user = _getUser(context);
    return FirestoreTreatmentRepository(user);
  }

  static User _getUser(BuildContext context) {
    var authenticationState = context.read<AuthenticationBloc>().state;
    if (authenticationState is Authenticated) {
      return authenticationState.user;
    }

    throw ArgumentError('No user currently logged in.');
  }
}
