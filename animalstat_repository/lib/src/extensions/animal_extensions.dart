import '../models/animal.dart';

extension AnimalExtensions on Animal {
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': this.animalNumber,
      'date_of_birth': this.dateOfBirth,
      'current_cage_number': this.currentCageNumber,
      'current_health_status': this.currentHealthStatus.index,
    };
  }
}
