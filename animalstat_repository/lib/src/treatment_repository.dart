import '../animalstat_repository.dart';

abstract class TreatmentRepository {
  Stream<List<Treatment>> getTreatments();
}
