import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:livestock/app/add_animal_detail/bloc/add_animal_detail_state.dart';
import 'package:livestock_repository/livestock_repository.dart';

abstract class AddAnimalDetailEvent extends Equatable {
  const AddAnimalDetailEvent();
}

class SaveAnimalHistoryRecord extends AddAnimalDetailEvent {
  SaveAnimalHistoryRecord({@required this.stateToSave});
  
  final AddAnimalDetailState stateToSave;
  
  @override
  List<Object> get props => [stateToSave];
}

class UpdateDiagnosis extends AddAnimalDetailEvent {
  UpdateDiagnosis({@required this.previousState, @required this.diagnosis,});
  
  final AddAnimalDetailState previousState;
  final Diagnoses diagnosis;

  @override
  List<Object> get props => [previousState, diagnosis];
}

class UpdateHealthStatus extends AddAnimalDetailEvent {
  UpdateHealthStatus({@required this.previousState, @required this.healthStatus,});
  
  final AddAnimalDetailState previousState;
  final HealthStates healthStatus;

  @override
  List<Object> get props => [previousState, healthStatus];
}

class UpdateTreatment extends AddAnimalDetailEvent {
  UpdateTreatment({@required this.previousState, @required this.treatment,});
  
  final AddAnimalDetailState previousState;
  final Treatments treatment;

  @override
  List<Object> get props => [previousState, treatment];
}