import 'package:animalstat_repository/animalstat_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../bloc.dart';

abstract class AddHistoryRecordEvent extends Equatable {
  const AddHistoryRecordEvent();
}

class SaveAnimalHistoryRecord extends AddHistoryRecordEvent {
  SaveAnimalHistoryRecord({@required this.stateToSave})
      : assert(stateToSave != null);

  final AddHistoryRecordState stateToSave;

  @override
  List<Object> get props => [stateToSave];
}

class UpdateCageNumber extends AddHistoryRecordEvent {
  UpdateCageNumber({
    @required this.cage,
  });

  final String cage;

  @override
  List<Object> get props => [cage];
}

class UpdateDiagnosis extends AddHistoryRecordEvent {
  UpdateDiagnosis({
    @required this.previousState,
    @required this.diagnosis,
  });

  final AddHistoryRecordState previousState;
  final Diagnosis diagnosis;

  @override
  List<Object> get props => [previousState, diagnosis];
}

class UpdateHealthStatus extends AddHistoryRecordEvent {
  UpdateHealthStatus({
    @required this.previousState,
    @required this.healthStatus,
  });

  final AddHistoryRecordState previousState;
  final HealthStates healthStatus;

  @override
  List<Object> get props => [previousState, healthStatus];
}

class UpdateNote extends AddHistoryRecordEvent {
  UpdateNote({
    @required this.note,
  });

  final String note;

  @override
  List<Object> get props => [note];
}

class UpdateTreatment extends AddHistoryRecordEvent {
  UpdateTreatment({
    @required this.previousState,
    @required this.treatment,
  });

  final AddHistoryRecordState previousState;
  final Treatment treatment;

  @override
  List<Object> get props => [previousState, treatment];
}

class UpdateTreatmentEndDate extends AddHistoryRecordEvent {
  UpdateTreatmentEndDate({@required this.endDate});

  final DateTime endDate;

  @override
  List<Object> get props => [endDate];
}
