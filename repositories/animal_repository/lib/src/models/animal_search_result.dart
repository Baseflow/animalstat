import 'package:meta/meta.dart';
import '../entities/entities.dart';

@immutable
class AnimalSearchResult {
  final int animalNumber;
  final DateTime dateOfBirth;
  final int cage;

  AnimalSearchResult(this.animalNumber, this.dateOfBirth, this.cage);

  @override
  int get hashCode =>
      animalNumber.hashCode ^ dateOfBirth.hashCode ^ cage.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnimalSearchResult &&
          runtimeType == other.runtimeType &&
          animalNumber == other.animalNumber &&
          dateOfBirth == other.dateOfBirth &&
          cage == other.cage;

  @override
  String toString() {
    return 'AnimalSearchResult{animalNumber: $animalNumber, dateOfBirth: $dateOfBirth, cage: $cage}';
  }

  AnimalSearchResultEntity toEntity() {
    return AnimalSearchResultEntity(animalNumber, dateOfBirth, cage);
  }

  static AnimalSearchResult fromEntity(AnimalSearchResultEntity entity) {
    return AnimalSearchResult(
      entity.animalNumber,
      entity.dateOfBirth,
      entity.cage,
    );
  }
}