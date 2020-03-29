import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:livestock_repository/livestock_repository.dart';
import 'extensions/document_snapshot_extensions.dart';

class FirestoreRecurringTreatmentsRepository
    extends RecurringTreatmentsRepository {
  final _recurringTreatmentsCollection =
      Firestore.instance.collection('recurring_treatments');

  @override
  Stream<List<RecurringTreatment>> findRecurringTreatmentsForDate(
    DateTime date,
  ) {
      return _recurringTreatmentsCollection
        .where('administration_date', isGreaterThanOrEqualTo: date)
        .where('administration_date', isLessThan: date.add(Duration(days: 1)))
        .snapshots()
        .map((snap) =>
            snap.documents.map((doc) => doc.toRecurringTreatment())
                          .where((treatment) => treatment.treatmentStatus == TreatmentStates.unknown).toList());
  }

  Future updateStatus(
    String id,
    TreatmentStates treatmentStatus,
  ) {
    final status = {
      'treatment_status': treatmentStatus.index,
    };

    return _recurringTreatmentsCollection.document(id).updateData(status);
  }
}
