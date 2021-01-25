import '../models/animal.dart';
import 'extensions.dart';

extension AnimalExtensions on Animal {
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': animalNumber,
      'date_of_birth': dateOfBirth,
      'current_cage_number': currentCageNumber,
      'health_info': healthInfo.toJson(),
    };
  }
}
