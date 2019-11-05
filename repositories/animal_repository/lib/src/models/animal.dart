import 'package:animal_repository/src/models/animal_health_states.dart';
import 'package:meta/meta.dart';

@immutable
class Animal {
  final int animalNumber;
  final DateTime dateOfBirth;
  final int currentCageNumber;
  final AnimalHealthStates currentHealthStatus;

  Animal(
    this.animalNumber,
    this.dateOfBirth,
    this.currentCageNumber,
    this.currentHealthStatus,
  );

  @override
  int get hashCode =>
      animalNumber.hashCode ^
      dateOfBirth.hashCode ^
      currentCageNumber.hashCode ^
      currentHealthStatus.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Animal &&
          runtimeType == other.runtimeType &&
          animalNumber == other.animalNumber &&
          dateOfBirth == other.dateOfBirth &&
          currentCageNumber == other.currentCageNumber &&
          currentHealthStatus == currentHealthStatus;

  @override
  String toString() {
    return 'Animal{animalNumber: $animalNumber, dateOfBirth: $dateOfBirth, currentCageNumber: $currentCageNumber, currentHealthStatus: $currentHealthStatus}';
  }
}
