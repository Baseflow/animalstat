import 'dart:math';

import 'entities/entities.dart';
import 'models/models.dart';
import 'animal_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreAnimalRepository implements AnimalRepository {
  final _animalCollection = Firestore.instance.collection('animals');

  @override
  Stream<List<AnimalSearchResult>> searchAnimals(int animalNumber) {
    if (animalNumber == null) {
      return Stream.empty();
    }

    int amountOfDigits = animalNumber.toString().length;
    int factor = pow(10, 5 - amountOfDigits);
    int start = animalNumber * factor;
    int end = (animalNumber + 1) * factor;

    return _animalCollection
        .where('animal_number', isGreaterThanOrEqualTo: start)
        .where('animal_number', isLessThan: end)
        .snapshots()
        .map((snap) => snap.documents
            .map((doc) => AnimalSearchResultEntity.fromSnapshot(doc).toModel())
            .toList());
  }

  @override
  Stream<List<AnimalHistoryRecord>> animalHistory(int animalNumber) {
    if (animalNumber == null) {
      return Stream.empty();
    }

    return _animalCollection
        .document(animalNumber.toString())
        .collection('history')
        .orderBy('seen_on', descending: true)
        .snapshots()
        .map((snap) => snap.documents
            .map((doc) => AnimalHistoryRecordEntity.fromSnapshot(doc).toModel())
            .toList());
  }

  @override
  Stream<Animal> loadAnimalByNumber(int animalNumber) {
    if (animalNumber == null) {
      throw ArgumentError.notNull('animalNumber');
    }

    return _animalCollection
        .document(animalNumber.toString())
        .snapshots()
        .map((snap) => AnimalEntity.fromSnapshot(snap).toModel());
  }

  @override
  Future insertHistoryRecord(
    int animalNumber,
    AnimalHistoryRecord animalHistoryRecord,
  ) {
    if (animalNumber == null) {
      throw ArgumentError.notNull('animalNumber');
    }

    if (animalHistoryRecord == null) {
      throw ArgumentError.notNull('animalHistoryRecord');
    }

    final timestamp = Timestamp.fromDate(animalHistoryRecord.seenOn);
    final historyRecordEntity =
        AnimalHistoryRecordEntity.fromModel(animalHistoryRecord);

    return _animalCollection
        .document(animalNumber.toString())
        .collection('history')
        .document(timestamp.millisecondsSinceEpoch.toString())
        .setData(historyRecordEntity.toJson());
  }
}
