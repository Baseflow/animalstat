import '../animalstat_repository.dart';

abstract class AnimalRepository {
  Stream<List<Animal>> findAnimals(int animalNumber);
  Stream<List<AnimalHistoryRecord>> findAnimalHistory(int animalNumber);
  Stream<Animal> findAnimalByNumber(int animalNumber);

  Future insertHistoryRecord(
    int animalNumber,
    AnimalHistoryRecord animalHistoryRecord,
  );
}
