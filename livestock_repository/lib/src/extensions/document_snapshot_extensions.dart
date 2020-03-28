import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:livestock_repository/src/converters/firestore_diagnoses_converter.dart';
import 'package:livestock_repository/src/converters/firestore_health_states_converter.dart';
import 'package:livestock_repository/src/converters/firestore_treatment_states_converter.dart';
import 'package:livestock_repository/src/converters/firestore_treatments_converter.dart';
import '../models/models.dart';

extension DocumentSnapshotExtension on DocumentSnapshot {
  /// Converts a Firestore DocumentSnapshot into an AnimalHistoryRecord.
  AnimalHistoryRecord toAnimalHistoryRecord() {
    final seenOn = this.data['seen_on'] as Timestamp;
    final treatmentEndDate = this.data['treatment_enddate'] as Timestamp;

    return AnimalHistoryRecord(
      this.data['cage'],
      FirestoreDiagnosesConverter.toEnum(this.data['diagnosis']),
      FirestoreHealthStatesConverter.toEnum(this.data['health_status']),
      seenOn.toDate(),
      FirestoreTreatmentsConverter.toEnum(this.data['treatment']),
      treatmentEndDate?.toDate() ?? null,
    );
  }

  /// Converts a Firestore DocumentSnapshot into an Animal.
  Animal toAnimal() {
    final animalNumber = int.parse(this.documentID);
    final dateOfBirth = this.data['date_of_birth'] as Timestamp;

    return Animal(
      animalNumber,
      dateOfBirth.toDate(),
      this.data['current_cage_number'],
      FirestoreHealthStatesConverter.toEnum(this.data['current_health_status']),
    );
  }

  /// Converts a Firestore DocumentSnapshot into a RecurringTreatment.
  RecurringTreatment toRecurringTreatment() {
    final administrationDate = this.data['administration_date'] as Timestamp;

    return RecurringTreatment(
      id: this.documentID,
      administrationDate: administrationDate.toDate(),
      animalNumber: this.data['animal_number'],
      cageNumber: this.data['cage_number'],
      diagnosis: FirestoreDiagnosesConverter.toEnum(this.data['diagnosis']),
      healthStatus: FirestoreHealthStatesConverter.toEnum(this.data['health_status']),
      treatment: FirestoreTreatmentsConverter.toEnum(this.data['treatment']),
      treatmentStatus: FirestoreTreatmentStatesConverter.toEnum(this.data['treatment_status']),
    );
  }
}
