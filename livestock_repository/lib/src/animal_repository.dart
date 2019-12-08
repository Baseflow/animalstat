import 'package:livestock_repository/livestock_repository.dart';

abstract class AnimalRepository {
  Stream<List<AnimalSearchResult>> searchAnimals(int animalNumber);
  Stream<List<AnimalHistoryRecord>> animalHistory(int animalNumber);

  Future<Animal> loadAnimalByNumber(int animalNumber);
}