// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:livestock_repository/livestock_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:livestock_repository/src/entities/converters/firestore_health_states_converter.dart';

class AnimalEntity extends Equatable {
  final int animalNumber;
  final DateTime dateOfBirth;
  final int currentCageNumber;
  final int currentHealthStatus;

  const AnimalEntity(
    this.animalNumber,
    this.dateOfBirth,
    this.currentCageNumber,
    this.currentHealthStatus,
  );

  @override
  List<Object> get props => [
        animalNumber,
        dateOfBirth,
        currentCageNumber,
        currentHealthStatus,
      ];

  @override
  String toString() {
    return 'AnimalEntity { animalNumber: $animalNumber, dateOfBirth: $dateOfBirth, currentCageNumber: $currentCageNumber, currentHealthStatus: $currentHealthStatus }';
  }

  static AnimalEntity fromSnapshot(DocumentSnapshot snap) {
    int animalNumber = int.parse(snap.documentID);
    Timestamp dateOfBirth = snap.data['date_of_birth'] as Timestamp;

    return AnimalEntity(
      animalNumber,
      dateOfBirth.toDate(),
      snap.data['current_cage_number'],
      snap.data['current_health_status'],
    );
  }

  static AnimalEntity fromModel(Animal model) {
    return AnimalEntity(
      model.animalNumber,
      model.dateOfBirth,
      model.currentCageNumber,
      model.currentHealthStatus.index,
    );
  }

  Animal toModel() {
    return Animal(
      animalNumber,
      dateOfBirth,
      currentCageNumber,
      FirestoreHealthStatesConverter.toEnum(currentHealthStatus),
    );
  }
}
