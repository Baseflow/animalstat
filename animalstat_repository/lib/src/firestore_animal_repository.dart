import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'animal_repository.dart';
import 'extensions/extensions.dart';
import 'models/models.dart';

class FirestoreAnimalRepository implements AnimalRepository {
  final CollectionReference _animalCollection;

  FirestoreAnimalRepository(User user)
      : assert(user != null),
        _animalCollection = FirebaseFirestore.instance
            .collection('companies/${user.companyId}/animals');

  @override
  Stream<List<Animal>> findAnimals(int animalNumber) {
    if (animalNumber == null) {
      return const Stream.empty();
    }

    final amountOfDigits = animalNumber.toString().length;
    final factor = pow(10, 5 - amountOfDigits);
    final start = animalNumber * factor;
    final end = (animalNumber + 1) * factor;

    return _animalCollection
        .where('animal_number', isGreaterThanOrEqualTo: start)
        .where('animal_number', isLessThan: end)
        .snapshots()
        .map((snap) => snap.docs.map((doc) => doc.toAnimal()).toList());
  }

  @override
  Stream<List<AnimalHistoryRecord>> findAnimalHistory(int animalNumber) {
    if (animalNumber == null) {
      return const Stream.empty();
    }

    return _animalCollection
        .doc(animalNumber.toString())
        .collection('history')
        .orderBy('seen_on', descending: true)
        .snapshots()
        .map((snap) =>
            snap.docs.map((doc) => doc.toAnimalHistoryRecord()).toList());
  }

  @override
  Stream<Animal> findAnimalByNumber(int animalNumber) {
    if (animalNumber == null) {
      throw ArgumentError.notNull('animalNumber');
    }

    return _animalCollection
        .doc(animalNumber.toString())
        .snapshots()
        .map((snap) => snap.toAnimal());
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
    final historyRecordJson = animalHistoryRecord.toJson();

    return _animalCollection
        .doc(animalNumber.toString())
        .collection('history')
        .doc(timestamp.millisecondsSinceEpoch.toString())
        .set(historyRecordJson);
  }
}
