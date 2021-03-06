import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../animalstat_repository.dart';

@immutable
class RecurringTreatment extends Equatable {
  final String id;
  final DateTime administrationDate;
  final int animalNumber;
  final int cageNumber;
  final Diagnosis diagnosis;
  final HealthStates healthStatus;
  final Treatment treatment;
  final TreatmentStates treatmentStatus;

  RecurringTreatment({
    this.id,
    this.administrationDate,
    this.animalNumber,
    this.cageNumber,
    this.diagnosis,
    this.healthStatus,
    this.treatment,
    this.treatmentStatus,
  });

  @override
  List<Object> get props => [
        id,
        administrationDate,
        animalNumber,
        cageNumber,
        diagnosis,
        healthStatus,
        treatment,
        treatmentStatus,
      ];

  @override
  bool get stringify => true;
}
