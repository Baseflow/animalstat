import 'package:meta/meta.dart';
import '../entities/entities.dart';

@immutable
class AnimalSearchResult {
  final int animalNumber;
  final DateTime dateOfBirth;
  final int currentCageNumber;

  AnimalSearchResult(this.animalNumber, this.dateOfBirth, this.currentCageNumber);

  @override
  int get hashCode =>
      animalNumber.hashCode ^ dateOfBirth.hashCode ^ currentCageNumber.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnimalSearchResult &&
          runtimeType == other.runtimeType &&
          animalNumber == other.animalNumber &&
          dateOfBirth == other.dateOfBirth &&
          currentCageNumber == other.currentCageNumber;

  @override
  String toString() {
    return 'AnimalSearchResult{animalNumber: $animalNumber, dateOfBirth: $dateOfBirth, currentCageNumber: $currentCageNumber}';
  }

  AnimalSearchResultEntity toEntity() {
    return AnimalSearchResultEntity(animalNumber, dateOfBirth, currentCageNumber);
  }

  static AnimalSearchResult fromEntity(AnimalSearchResultEntity entity) {
    return AnimalSearchResult(
      entity.animalNumber,
      entity.dateOfBirth,
      entity.currentCageNumber,
    );
  }
}