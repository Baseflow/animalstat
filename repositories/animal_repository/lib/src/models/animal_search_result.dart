import 'package:animal_repository/src/models/animal_health_states.dart';
import 'package:meta/meta.dart';

@immutable
class AnimalSearchResult {
  final int animalNumber;
  final DateTime dateOfBirth;
  final int currentCageNumber;
  final AnimalHealthStates currentHealthStatus;

  AnimalSearchResult(
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
      other is AnimalSearchResult &&
          runtimeType == other.runtimeType &&
          animalNumber == other.animalNumber &&
          dateOfBirth == other.dateOfBirth &&
          currentCageNumber == other.currentCageNumber &&
          currentHealthStatus == currentHealthStatus;

  @override
  String toString() {
    return 'AnimalSearchResult{animalNumber: $animalNumber, dateOfBirth: $dateOfBirth, currentCageNumber: $currentCageNumber, currentHealthStatus: $currentHealthStatus}';
  }
}
