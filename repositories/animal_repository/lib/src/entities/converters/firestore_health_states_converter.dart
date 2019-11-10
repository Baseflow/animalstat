import 'package:animal_repository/animal_repository.dart';

class FirestoreHealthStatesConverter {
  static HealthStates toEnum(String firestorePath){
    switch(firestorePath) {
      case 'health_states/Deceased':
        return HealthStates.deceased;
      case 'health_states/Healthy':
        return HealthStates.healthy;
      case 'health_states/Ill':
        return HealthStates.ill;
      case 'health_states/Suspicious':
        return HealthStates.suspicious;
      default:
        return HealthStates.unknown;
    }
  }

  static String fromEnum(HealthStates healthState)
  {
    switch(healthState) {
      case HealthStates.deceased:
        return 'health_states/Deceased';
      case HealthStates.healthy:
        return 'health_states/Healthy';
      case HealthStates.ill:
        return 'health_states/Ill';
      case HealthStates.suspicious:
        return 'health_states/Suspicious';
      default:
        return null;
    }
  }
}