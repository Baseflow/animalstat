import '../animalstat_repository.dart';

abstract class RecurringTreatmentsRepository {
  Stream<List<RecurringTreatment>> findRecurringTreatmentsForDate(
    DateTime date,
  );

  Future updateStatus(
    String id,
    TreatmentStates treatmentStatus,
  );
}
