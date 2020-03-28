import 'package:livestock_repository/livestock_repository.dart';
import 'package:livestock_repository/src/models/diagnoses.dart';
import 'package:livestock_repository/src/models/health_states.dart';
import 'package:livestock_repository/src/models/treatments.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

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
    return 'AnimalHistoryRecord{diagnosis: $diagnosis, healthStaus: $healthStatus, treatment: $treatment, seenOn: $seenOn, endDate: $treatmentEndDate}';
  }
}
