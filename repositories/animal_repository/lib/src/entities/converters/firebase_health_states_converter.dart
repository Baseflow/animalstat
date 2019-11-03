import 'package:animal_repository/animal_repository.dart';

class FirestoreHealthStatesConverter {
  static AnimalHealthStates toEnum(String firestorePath){
    switch(firestorePath) {
      case 'health_states/Deceased':
        return AnimalHealthStates.deceased;
      case 'health_states/Healthy':
        return AnimalHealthStates.healthy;
      case 'health_states/Ill':
        return AnimalHealthStates.ill;
      case 'health_states/Suspicious':
        return AnimalHealthStates.suspicious;
      default:
        return AnimalHealthStates.unknown;
    }
  }

  static String fromEnum(AnimalHealthStates healthState)
  {
    switch(healthState) {
      case AnimalHealthStates.deceased:
        return 'health_states/Deceased';
      case AnimalHealthStates.healthy:
        return 'health_states/Healthy';
      case AnimalHealthStates.ill:
        return 'health_states/Ill';
      case AnimalHealthStates.suspicious:
        return 'health_states/Suspicious';
      default:
        return null;
    }
  }
}