import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:animalstat_repository/animalstat_repository.dart';
import 'package:meta/meta.dart';
import './bloc.dart';

class AddHistoryRecordBloc
    extends Bloc<AddHistoryRecordEvent, AddHistoryRecordState> {
  final int _animalNumber;
  final AnimalRepository _animalRepository;

  AddHistoryRecordBloc({
    @required int animalNumber,
    @required AnimalRepository animalRepository,
  })  : assert(animalNumber != null),
        assert(animalRepository != null),
        _animalNumber = animalNumber,
        _animalRepository = animalRepository;

  @override
  AddHistoryRecordState get initialState =>
      AddHistoryRecordState.initial(_animalNumber);

  @override
  Stream<AddHistoryRecordState> mapEventToState(
    AddHistoryRecordEvent event,
  ) async* {
    if (event is UpdateCageNumber) {
      yield* _updateCageNumber(event);
    } else if (event is UpdateDiagnosis) {
      yield* _updateDiagnoses(event);
    } else if (event is UpdateHealthStatus) {
      yield* _updateHealthStatus(event);
    } else if (event is UpdateTreatment) {
      yield* _updateTreatment(event);
    } else if (event is UpdateTreatmentEndDate) {
      yield* _updateTreatmentEndDate(event);
    } else if (event is SaveAnimalHistoryRecord) {
      yield* _saveAnimalHistoryRecord(event);
    }
  }

  Stream<AddHistoryRecordState> _saveAnimalHistoryRecord(
      SaveAnimalHistoryRecord event) async* {
    await _animalRepository.insertHistoryRecord(
      event.stateToSave.animalNumber,
      event.stateToSave.toModel(),
    );

    yield state.copyWith(isSaved: true);
  }

  Stream<AddHistoryRecordState> _updateCageNumber(
    UpdateCageNumber event,
  ) async* {
    var cage = int.tryParse(event.cage);

    yield AddHistoryRecordState(
      animalNumber: state.animalNumber,
      cage: cage,
      diagnosis: state.diagnosis,
      healthStatus: state.healthStatus,
      isSaved: state.isSaved,
      seenOn: state.seenOn,
      treatment: state.treatment,
      );
  }

  Stream<AddHistoryRecordState> _updateDiagnoses(
    UpdateDiagnosis event,
  ) async* {
    final diagnosis = event.diagnosis == event.previousState.diagnosis
        ? Diagnoses.none
        : event.diagnosis;
    final treatment = !allowTreatmentSelection(
      event.previousState.healthStatus,
      diagnosis,
    )
        ? Treatments.none
        : null;

    yield event.previousState.copyWith(
      diagnosis: diagnosis,
      treatment: treatment,
    );
  }

  Stream<AddHistoryRecordState> _updateHealthStatus(
    UpdateHealthStatus event,
  ) async* {
    final healthStatus = event.healthStatus == event.previousState.healthStatus
        ? HealthStates.unknown
        : event.healthStatus;
    final diagnosis =
        !allowDiagnosisSelection(healthStatus) ? Diagnoses.none : null;
    final treatment = !allowTreatmentSelection(healthStatus, diagnosis)
        ? Treatments.none
        : null;

    yield event.previousState.copyWith(
      diagnosis: diagnosis,
      healthStatus: healthStatus,
      treatment: treatment,
    );
  }

  Stream<AddHistoryRecordState> _updateTreatment(
    UpdateTreatment event,
  ) async* {
    final treatment = event.treatment == event.previousState.treatment
        ? Treatments.none
        : event.treatment;

    yield event.previousState.copyWith(treatment: treatment);
  }

  Stream<AddHistoryRecordState> _updateTreatmentEndDate(
    UpdateTreatmentEndDate event,
  ) async* {
    yield state.copyWith(treatmentEndDate: event.endDate);
  }

  static bool allowDiagnosisSelection(HealthStates healthStatus) =>
      healthStatus == HealthStates.ill ||
      healthStatus == HealthStates.suspicious;

  static bool allowTreatmentSelection(
          HealthStates healthStatus, Diagnoses diagnosis) =>
      AddHistoryRecordBloc.allowDiagnosisSelection(healthStatus) &&
      diagnosis != Diagnoses.none;

  static bool canSaveState(AddHistoryRecordState state) {
    if(state.cage == null || state.healthStatus == null) {
      return false;
    }

    if(state.healthStatus == HealthStates.deceased || state.healthStatus == HealthStates.healthy) {
      return true;
    }

    if(state.healthStatus == HealthStates.suspicious && state.diagnosis != null && state.diagnosis != Diagnoses.none) {
      return true;
    }

    if(state.healthStatus == HealthStates.ill && state.diagnosis != null && state.diagnosis != Diagnoses.none && state.treatment != Treatments.none) {
      return true;
    }

    return false;
  }
}
