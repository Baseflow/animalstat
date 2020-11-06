import '../models/health_states.dart';

class FirestoreHealthStatesConverter {
  static HealthStates toEnum(int healthStatus) {
    return healthStatus == null
        ? HealthStates.unknown
        : HealthStates.values[healthStatus];
  }
}
