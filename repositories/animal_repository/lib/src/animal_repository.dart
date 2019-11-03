import 'package:animal_repository/animal_repository.dart';

abstract class AnimalRepository {
  Stream<List<AnimalSearchResult>> searchAnimals(int animalNumber);
}