import 'dart:math';

import 'entities/entities.dart';
import 'models/models.dart';
import 'animal_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAnimalRepository implements AnimalRepository {
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
  Future<Animal> loadAnimalByNumber(int animalNumber) {
    if (animalNumber == null) {
      throw ArgumentError.notNull('animalNumber');
    }

    return _animalCollection
        .document(animalNumber.toString())
        .get()
        .then((doc) => AnimalEntity.fromSnapshot(doc).toModel());
  }
}
