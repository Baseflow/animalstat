import 'package:livestock_repository/livestock_repository.dart';

class FirestoreHealthStatesConverter {
  static HealthStates toEnum(int healthStatus){
    return healthStatus == null
      ? HealthStates.unknown
      : HealthStates.values[healthStatus];
  }
}