import 'package:animalstat_repository/src/models/animal_health_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../converters/firestore_health_states_converter.dart';
import '../converters/firestore_treatment_states_converter.dart';
import '../extensions/extensions.dart';
import '../models/models.dart';

extension DocumentSnapshotExtension on DocumentSnapshot {
  /// Converts a Firestore DocumentSnapshot into an AnimalHistoryRecord.
  AnimalHistoryRecord toAnimalHistoryRecord() {
    final dataMap = data();
    final seenOn = dataMap['seen_on'] as Timestamp;
    final treatmentEndDate = dataMap['treatment_enddate'] as Timestamp;

    final userId = dataMap['seen_by.user_id'];
    final userName = dataMap['seen_by_user_name'];
    UserInfo userInfo = null;
    if (userId != null && userName != null) {
      userInfo = UserInfo(
        userId,
        userName,
      );
    }

    return AnimalHistoryRecord(
      dataMap['cage'],
      dataMap.toDiagnosis(),
      FirestoreHealthStatesConverter.toEnum(dataMap['health_status']),
      dataMap['note'],
      userInfo,
      seenOn.toDate(),
      dataMap.toTreatment(),
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
      dateOfBirth?.toDate(),
      dataMap['current_cage_number'],
      _toAnimalHealthInfo(dataMap['health_info']),
      dataMap['note'],
    );
  }

  AnimalHealthInfo _toAnimalHealthInfo(Map<String, dynamic> dataMap) {
    if (dataMap == null) {
      return null;
    }

    final updatedOn = dataMap['updated_on'] as Timestamp;

    return AnimalHealthInfo(
      diagnosis: dataMap['diagnosis'],
      healthStatus: FirestoreHealthStatesConverter.toEnum(dataMap['status']),
      updatedOn: updatedOn.toDate(),
    );
  }

  /// Converts a Firestore DocumentSnapshot into a Diagnosis
  Diagnosis toDiagnosis() {
    final dataMap = data();

    return Diagnosis(
      id,
      dataMap['name'],
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
      diagnosis: dataMap.toDiagnosis(),
      healthStatus:
          FirestoreHealthStatesConverter.toEnum(dataMap['health_status']),
      historyRecordId: dataMap['history_record_id'],
      note: dataMap['note'],
      treatment: dataMap.toTreatment(),
      treatmentStatus:
          FirestoreTreatmentStatesConverter.toEnum(dataMap['treatment_status']),
    );
  }

  /// Converts a Firestore DocumentSnapshot into a Treatment
  Treatment toTreatment() {
    final dataMap = data();

    return Treatment(
      id,
      dataMap['diagnosis_id'],
      dataMap['name'],
    );
  }
}
