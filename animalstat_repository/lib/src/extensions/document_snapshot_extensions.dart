import 'package:cloud_firestore/cloud_firestore.dart';

import '../converters/firestore_diagnoses_converter.dart';
import '../converters/firestore_health_states_converter.dart';
import '../converters/firestore_treatment_states_converter.dart';
import '../converters/firestore_treatments_converter.dart';
import '../models/models.dart';

extension DocumentSnapshotExtension on DocumentSnapshot {
  /// Converts a Firestore DocumentSnapshot into an AnimalHistoryRecord.
  AnimalHistoryRecord toAnimalHistoryRecord() {
    final dataMap = data();
    final seenOn = dataMap['seen_on'] as Timestamp;
    final treatmentEndDate = dataMap['treatment_enddate'] as Timestamp;

    return AnimalHistoryRecord(
      dataMap['cage'],
      FirestoreDiagnosesConverter.toEnum(dataMap['diagnosis']),
      FirestoreHealthStatesConverter.toEnum(dataMap['health_status']),
      seenOn.toDate(),
      FirestoreTreatmentsConverter.toEnum(dataMap['treatment']),
      treatmentEndDate?.toDate() ?? null,
    );
  }

  /// Converts a Firestore DocumentSnapshot into an Animal.
  Animal toAnimal() {
    final dataMap = data();
    final animalNumber = int.parse(id);
    final dateOfBirth = dataMap['date_of_birth'] as Timestamp;

    return Animal(
      animalNumber,
      dateOfBirth.toDate(),
      dataMap['current_cage_number'],
      FirestoreHealthStatesConverter.toEnum(dataMap['current_health_status']),
    );
  }

  /// Converts a Firestore DocumentSnapshot into a RecurringTreatment.
  RecurringTreatment toRecurringTreatment() {
    final dataMap = data();
    final administrationDate = dataMap['administration_date'] as Timestamp;

    return RecurringTreatment(
      id: id,
      administrationDate: administrationDate.toDate(),
      animalNumber: dataMap['animal_number'],
      cageNumber: dataMap['cage_number'],
      diagnosis: FirestoreDiagnosesConverter.toEnum(dataMap['diagnosis']),
      healthStatus:
          FirestoreHealthStatesConverter.toEnum(dataMap['health_status']),
      treatment: FirestoreTreatmentsConverter.toEnum(dataMap['treatment']),
      treatmentStatus:
          FirestoreTreatmentStatesConverter.toEnum(dataMap['treatment_status']),
    );
  }
}
