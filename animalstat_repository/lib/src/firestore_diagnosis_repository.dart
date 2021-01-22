import 'package:cloud_firestore/cloud_firestore.dart';

import '../animalstat_repository.dart';
import 'extensions/document_snapshot_extensions.dart';

class FirestoreDiagnosisRepository extends DiagnosisRepository {
  final CollectionReference _diagnosisCollection;

  FirestoreDiagnosisRepository(User user)
      : assert(user != null),
        _diagnosisCollection = FirebaseFirestore.instance
            .collection('companies/${user.companyId}/diagnoses');

  @override
  Stream<List<Diagnosis>> getDiagnoses() {
    return _diagnosisCollection
        .orderBy('name')
        .snapshots()
        .map((snap) => snap.docs.map((doc) => doc.toDiagnosis()).toList());
  }
}
