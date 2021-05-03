import 'package:cloud_firestore/cloud_firestore.dart';

import '../animalstat_repository.dart';
import 'extensions/document_snapshot_extensions.dart';

class FirestoreRecurringTreatmentsRepository
    extends RecurringTreatmentsRepository {
  final CollectionReference _recurringTreatmentsCollection;

  FirestoreRecurringTreatmentsRepository(User user)
      : assert(user != null),
        _recurringTreatmentsCollection = FirebaseFirestore.instance
            .collection('companies/${user.companyId}/recurring_treatments');

  @override
  Stream<List<RecurringTreatment>> findRecurringTreatmentsForDate(
    DateTime date,
  ) {
    return _recurringTreatmentsCollection
        .where('administration_date', isGreaterThanOrEqualTo: date)
        .where('administration_date',
            isLessThan: date.add(const Duration(days: 1)))
        .orderBy('administration_date')
        .snapshots()
        .map((snap) =>
            snap.docs.map((doc) => doc.toRecurringTreatment()).toList());
  }

  Future updateStatus(
    String id,
    TreatmentStates treatmentStatus,
  ) {
    final status = {
      'treatment_status': treatmentStatus.index,
    };

    return _recurringTreatmentsCollection.doc(id).update(status);
  }
}
