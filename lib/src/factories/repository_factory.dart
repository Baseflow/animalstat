import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livestock/app/authentication/bloc/bloc.dart';
import 'package:livestock_repository/livestock_repository.dart';

class RepositoryFactory {
  static AnimalRepository createAnimalRepository(BuildContext context) {
    var user = _getUser(context);
    return FirestoreAnimalRepository(user);
  }

  static RecurringTreatmentsRepository createRecurringTreatmentsRepository(BuildContext context) {
    var user = _getUser(context);
    return FirestoreRecurringTreatmentsRepository(user);
  }

  static User _getUser(BuildContext context) {
    var authenticationState = context.bloc<AuthenticationBloc>().state;
    if (authenticationState is Authenticated) {
      return authenticationState.user;
    }

    throw ArgumentError('No user currently logged in.');
  }
}