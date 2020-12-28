import 'package:cloud_firestore/cloud_firestore.dart';

import '../converters/firestore_diagnoses_converter.dart';
import '../converters/firestore_health_states_converter.dart';
import '../converters/firestore_treatment_states_converter.dart';
import '../converters/firestore_treatments_converter.dart';
import '../models/models.dart';

extension DocumentSnapshotExtension on DocumentSnapshot {
  /// Converts a Firestore DocumentSnapshot into an AnimalHistoryRecord.
  AnimalHistoryRecord toAnimalHistoryRecord() {
    final seenOn = data['seen_on'] as Timestamp;
    final treatmentEndDate = data['treatment_enddate'] as Timestamp;

    return AnimalHistoryRecord(
      data['cage'],
      FirestoreDiagnosesConverter.toEnum(data['diagnosis']),
      FirestoreHealthStatesConverter.toEnum(data['health_status']),
      seenOn.toDate(),
      FirestoreTreatmentsConverter.toEnum(data['treatment']),
      treatmentEndDate?.toDate() ?? null,
    );
  }

  /// Converts a Firestore DocumentSnapshot into an Animal.
  Animal toAnimal() {
    final animalNumber = int.parse(documentID);
    final dateOfBirth = data['date_of_birth'] as Timestamp;

    return Animal(
      animalNumber,
      dateOfBirth.toDate(),
      data['current_cage_number'],
      FirestoreHealthStatesConverter.toEnum(data['current_health_status']),
    );
  }

  /// Converts a Firestore DocumentSnapshot into a RecurringTreatment.
  RecurringTreatment toRecurringTreatment() {
    final administrationDate = data['administration_date'] as Timestamp;

    return RecurringTreatment(
      id: documentID,
      administrationDate: administrationDate.toDate(),
      animalNumber: data['animal_number'],
      cageNumber: data['cage_number'],
      diagnosis: FirestoreDiagnosesConverter.toEnum(data['diagnosis']),
      healthStatus:
          FirestoreHealthStatesConverter.toEnum(data['health_status']),
      treatment: FirestoreTreatmentsConverter.toEnum(data['treatment']),
      treatmentStatus:
          FirestoreTreatmentStatesConverter.toEnum(data['treatment_status']),
    );
  }
}
