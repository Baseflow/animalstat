// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class AnimalSearchResultEntity extends Equatable {
  final int animalNumber;
  final DateTime dateOfBirth;
  final int currentCageNumber;

  const AnimalSearchResultEntity(this.animalNumber, this.dateOfBirth, this.currentCageNumber,);

  Map<String, Object> toJson() {
    return {
      "animal_number": animalNumber,
      "date_of_birth": dateOfBirth.toIso8601String(),
      "current_cage_number": currentCageNumber,
    };
  }

  @override
  List<Object> get props => [animalNumber, dateOfBirth, currentCageNumber];

  @override
  String toString() {
    return 'AnimalSearchResultEntity { animalNumber: $animalNumber, dateOfBirth: $dateOfBirth, currentCageNumber: $currentCageNumber }';
  }

  static AnimalSearchResultEntity fromJson(Map<String, Object> json) {
    DateTime dateOfBirth = DateTime.parse(json['date_of_birth']);
    
    return AnimalSearchResultEntity(
      json["animal_number"] as int,
      dateOfBirth,
      json["current_cage_number"] as int,
    );
  }

  static AnimalSearchResultEntity fromSnapshot(DocumentSnapshot snap) {
    int animalNumber = int.parse(snap.documentID);
    Timestamp dateOfBirth = snap.data['date_of_birth'] as Timestamp;

    return AnimalSearchResultEntity(
      animalNumber,
      dateOfBirth.toDate(),
      snap.data['current_cage_number'],
    );
  }
}