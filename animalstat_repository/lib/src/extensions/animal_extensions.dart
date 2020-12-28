import '../models/animal.dart';

extension AnimalExtensions on Animal {
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': animalNumber,
      'date_of_birth': dateOfBirth,
      'current_cage_number': currentCageNumber,
      'current_health_status': currentHealthStatus.index,
    };
  }
}
