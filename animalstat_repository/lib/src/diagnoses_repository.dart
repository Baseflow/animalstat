import '../animalstat_repository.dart';

abstract class DiagnosisRepository {
  Stream<List<Diagnosis>> getDiagnoses();
}
