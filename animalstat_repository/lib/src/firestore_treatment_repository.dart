import 'package:cloud_firestore/cloud_firestore.dart';

import '../animalstat_repository.dart';
import 'extensions/document_snapshot_extensions.dart';

class FirestoreTreatmentRepository extends TreatmentRepository {
  final CollectionReference _treatmentCollection;

  FirestoreTreatmentRepository(User user)
      : assert(user != null),
        _treatmentCollection = FirebaseFirestore.instance
            .collection('companies/${user.companyId}/treatments');

  @override
  Stream<List<Treatment>> getTreatments() {
    return _treatmentCollection
        .orderBy('name')
        .snapshots()
        .map((snap) => snap.docs.map((doc) => doc.toTreatment()).toList());
  }
}
