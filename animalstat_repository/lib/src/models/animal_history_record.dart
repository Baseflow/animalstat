import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../animalstat_repository.dart';
import 'diagnosis.dart';
import 'health_states.dart';
import 'treatment.dart';

@immutable
class AnimalHistoryRecord extends Equatable {
  final int cage;
  final UserInfo seenBy;
  final DateTime seenOn;
  final Diagnosis diagnosis;
  final HealthStates healthStatus;
  final Treatment treatment;
  final DateTime treatmentEndDate;

  AnimalHistoryRecord(
    this.cage,
    this.diagnosis,
    this.healthStatus,
    this.seenBy,
    this.seenOn,
    this.treatment,
    this.treatmentEndDate,
  );

  @override
  List<Object> get props => [
        cage,
        diagnosis,
        healthStatus,
        seenBy,
        seenOn,
        treatment,
        treatmentEndDate,
      ];

  @override
  bool get stringify => true;
}

class UserInfo extends Equatable {
  const UserInfo(
    this.userId,
    this.userName,
  )   : assert(userId != null),
        assert(userName != null);

  final String userId;
  final String userName;

  @override
  List<Object> get props => [
        userId,
        userName,
      ];
}
