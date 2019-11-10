// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:animal_repository/animal_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'converters/firestore_diagnoses_converter.dart';
import 'converters/firestore_health_states_converter.dart';
import 'converters/firestore_treatments_converter.dart';

class AnimalHistoryRecordEntity extends Equatable {
  final int cageNumber;
  final String diagnosis;
  final String healthStatus;
  final DateTime seenOn;
  final String treatment;

  const AnimalHistoryRecordEntity(
      this.cageNumber,
      this.diagnosis,
      this.healthStatus,
      this.seenOn,
      this.treatment,
      );

  @override
  List<Object> get props => [
    cageNumber,
    diagnosis,
    healthStatus,
    seenOn,
    treatment,
  ];

  @override
  String toString() {
    return 'AnimalHistoryRecordEntity { cageNumber: $cageNumber, diagnosis: $diagnosis, healthStatus: $healthStatus, seenOn: $seenOn, treatments: $treatment }';
  }

  static AnimalHistoryRecordEntity fromSnapshot(DocumentSnapshot snap) {
    int cageNumber = snap.data['cage'];
    Timestamp seenOn = snap.data['seen_on'] as Timestamp;
    DocumentReference diagnosesRef = snap.data['diagnosis'] as DocumentReference;
    DocumentReference healthStatusRef = snap.data['health_status'] as DocumentReference;
    DocumentReference treatment = snap.data['treatment'] as DocumentReference;

    return AnimalHistoryRecordEntity(
      cageNumber,
      diagnosesRef?.path,
      healthStatusRef?.path,
      seenOn.toDate(),
      treatment?.path,
    );
  }

  static AnimalHistoryRecordEntity fromModel(AnimalHistoryRecord model) {
    return AnimalHistoryRecordEntity(
      model.cageNumber,
      FirestoreDiagnosesConverter.fromEnum(model.diagnosis),
      FirestoreHealthStatesConverter.fromEnum(model.healthStatus),
      model.seenOn,
      FirestoreTreatmentsConverter.fromEnum(model.treatment),
    );
  }

  AnimalHistoryRecord toModel() {
    return AnimalHistoryRecord(
      cageNumber,
      FirestoreDiagnosesConverter.toEnum(diagnosis),
      FirestoreHealthStatesConverter.toEnum(healthStatus),
      seenOn,
      FirestoreTreatmentsConverter.toEnum(treatment),
    );
  }
}
