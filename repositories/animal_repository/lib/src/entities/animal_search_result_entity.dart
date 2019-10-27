// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class AnimalSearchResultEntity extends Equatable {
  final int animalNumber;
  final DateTime dateOfBirth;
  final int cage;

  const AnimalSearchResultEntity(this.animalNumber, this.dateOfBirth, this.cage,);

  Map<String, Object> toJson() {
    return {
      "animal_number": animalNumber,
      "date_of_birth": dateOfBirth.toIso8601String(),
      "cage": cage,
    };
  }

  @override
  List<Object> get props => [animalNumber, dateOfBirth, cage];

  @override
  String toString() {
    return 'AnimalSearchResultEntity { animalNumber: $animalNumber, dateOfBirth: $dateOfBirth, cage: $cage }';
  }

  static AnimalSearchResultEntity fromJson(Map<String, Object> json) {
    DateTime dateOfBirth = DateTime.parse(json['date_of_birth']);
    
    return AnimalSearchResultEntity(
      json["animal_number"] as int,
      dateOfBirth,
      json["cage"] as int,
    );
  }

  static AnimalSearchResultEntity fromSnapshot(DocumentSnapshot snap) {
    int animalNumber = int.parse(snap.documentID);
    Timestamp dateOfBirth = snap.data['date_of_birth'] as Timestamp;

    return AnimalSearchResultEntity(
      animalNumber,
      dateOfBirth.toDate(),
      snap.data['cage'],
    );
  }
}