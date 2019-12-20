import 'package:livestock_repository/livestock_repository.dart';
import 'package:livestock_repository/src/models/diagnoses.dart';
import 'package:livestock_repository/src/models/health_states.dart';
import 'package:livestock_repository/src/models/treatments.dart';
import 'package:meta/meta.dart';

@immutable
class AnimalHistoryRecord {
  final DateTime seenOn;
  final Diagnoses diagnosis;
  final HealthStates healthStatus;
  final Treatments treatment;

  AnimalHistoryRecord(
      this.diagnosis,
      this.healthStatus,
      this.seenOn,
      this.treatment,
      );

  @override
  int get hashCode =>
      diagnosis.hashCode ^
      healthStatus.hashCode ^
      seenOn.hashCode ^
      treatment.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AnimalHistoryRecord &&
              runtimeType == other.runtimeType &&
              diagnosis == other.diagnosis &&
              healthStatus == other.healthStatus &&
              treatment == other.treatment &&
              seenOn == other.seenOn;

  @override
  String toString() {
    return 'AnimalHistoryRecord{diagnosis: $diagnosis, healthStaus: $healthStatus, treatment: $treatment, seenOn: $seenOn}';
  }
}
