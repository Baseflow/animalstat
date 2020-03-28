import '../livestock_repository.dart';

abstract class RecurringTreatmentsRepository {
  Stream<List<RecurringTreatment>> findRecurringTreatmentsForDate(DateTime date);
}