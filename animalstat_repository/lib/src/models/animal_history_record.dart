import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'diagnoses.dart';
import 'health_states.dart';
import 'treatments.dart';

@immutable
class AnimalHistoryRecord extends Equatable {
  final int cage;
  final DateTime seenOn;
  final Diagnoses diagnosis;
  final HealthStates healthStatus;
  final Treatments treatment;
  final DateTime treatmentEndDate;

  AnimalHistoryRecord(
    this.cage,
    this.diagnosis,
    this.healthStatus,
    this.seenOn,
    this.treatment,
    this.treatmentEndDate,
  );

  @override
  List<Object> get props => [
        cage,
        diagnosis,
        healthStatus,
        seenOn,
        treatment,
        treatmentEndDate,
      ];

  @override
  String toString() {
    // ignore: lines_longer_than_80_chars
    return 'AnimalHistoryRecord{diagnosis: $diagnosis, healthStatus: $healthStatus, treatment: $treatment, seenOn: $seenOn, endDate: $treatmentEndDate}';
  }
}
