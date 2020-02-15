// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:livestock_repository/livestock_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:livestock_repository/src/entities/converters/firestore_diagnoses_converter.dart';
import 'package:livestock_repository/src/entities/converters/firestore_health_states_converter.dart';
import 'package:livestock_repository/src/entities/converters/firestore_treatments_converter.dart';

class AnimalHistoryRecordEntity extends Equatable {
  final int cage;
  final int diagnosis;
  final int healthStatus;
  final DateTime seenOn;
  final int treatment;

  const AnimalHistoryRecordEntity(
    this.cage,
    this.diagnosis,
    this.healthStatus,
    this.seenOn,
    this.treatment,
  );

  @override
  List<Object> get props => [
        diagnosis,
        healthStatus,
        seenOn,
        treatment,
      ];

  @override
  String toString() {
    return 'AnimalHistoryRecordEntity {cage: $cage, diagnosis: $diagnosis, healthStatus: $healthStatus, seenOn: $seenOn, treatments: $treatment }';
  }

  static AnimalHistoryRecordEntity fromSnapshot(DocumentSnapshot snap) {
    Timestamp seenOn = snap.data['seen_on'] as Timestamp;

    return AnimalHistoryRecordEntity(
      snap.data['cage'],
      snap.data['diagnosis'],
      snap.data['health_status'],
      seenOn.toDate(),
      snap.data['treatment'],
    );
  }

  static AnimalHistoryRecordEntity fromModel(AnimalHistoryRecord model) {
    return AnimalHistoryRecordEntity(
      model.cage,
      model.diagnosis.index,
      model.healthStatus.index,
      model.seenOn,
      model.treatment.index,
    );
  }

  AnimalHistoryRecord toModel() {
    return AnimalHistoryRecord(
      cage,
      FirestoreDiagnosesConverter.toEnum(diagnosis),
      FirestoreHealthStatesConverter.toEnum(healthStatus),
      seenOn,
      FirestoreTreatmentsConverter.toEnum(treatment),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cage': cage,
      'diagnosis': diagnosis,
      'health_status': healthStatus,
      // TODO: Implement support for 'seenBy' parameter...
      'seen_by': 'Maurits',
      'seen_on': seenOn,
      'treatment': treatment,
    };
  }
}
