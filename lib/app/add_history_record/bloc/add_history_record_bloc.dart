import 'dart:async';

import 'package:animalstat_repository/animalstat_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import './bloc.dart';

class AddHistoryRecordBloc
    extends Bloc<AddHistoryRecordEvent, AddHistoryRecordState> {
  final AnimalRepository _animalRepository;

  AddHistoryRecordBloc({
    @required int animalNumber,
    @required User user,
    @required AnimalRepository animalRepository,
  })  : assert(animalNumber != null),
        assert(animalRepository != null),
        assert(user != null),
        _animalRepository = animalRepository,
        super(AddHistoryRecordState.initial(animalNumber, user));

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

    yield state.copyWith(
      event.stateToSave.diagnosis,
      event.stateToSave.treatment,
      isSaved: true,
    );
  }

  Stream<AddHistoryRecordState> _updateCageNumber(
    UpdateCageNumber event,
  ) async* {
    final cage = int.tryParse(event.cage);

    yield state.copyWith(
      state.diagnosis,
      state.treatment,
      cage: cage,
    );
  }

  Stream<AddHistoryRecordState> _updateDiagnoses(
    UpdateDiagnosis event,
  ) async* {
    final diagnosis = event.diagnosis == event.previousState.diagnosis
        ? null
        : event.diagnosis;
    final treatment = !allowTreatmentSelection(
      event.previousState.healthStatus,
      diagnosis,
    )
        ? null
        : event.previousState.treatment;

    yield event.previousState.copyWith(
      diagnosis,
      treatment,
    );
  }

  Stream<AddHistoryRecordState> _updateHealthStatus(
    UpdateHealthStatus event,
  ) async* {
    final healthStatus = event.healthStatus == event.previousState.healthStatus
        ? HealthStates.unknown
        : event.healthStatus;
    final diagnosis = !allowDiagnosisSelection(healthStatus)
        ? null
        : event.previousState.diagnosis;
    final treatment = !allowTreatmentSelection(healthStatus, diagnosis)
        ? null
        : event.previousState.treatment;

    yield event.previousState.copyWith(
      diagnosis,
      treatment,
      healthStatus: healthStatus,
    );
  }

  Stream<AddHistoryRecordState> _updateTreatment(
    UpdateTreatment event,
  ) async* {
    final treatment = event.treatment == event.previousState.treatment
        ? null
        : event.treatment;

    yield event.previousState.copyWith(
      state.diagnosis,
      treatment,
    );
  }

  Stream<AddHistoryRecordState> _updateTreatmentEndDate(
    UpdateTreatmentEndDate event,
  ) async* {
    yield state.copyWith(state.diagnosis, state.treatment,
        treatmentEndDate: event.endDate);
  }

  static bool allowDiagnosisSelection(HealthStates healthStatus) =>
      healthStatus == HealthStates.ill ||
      healthStatus == HealthStates.suspicious;

  static bool allowTreatmentSelection(
          HealthStates healthStatus, Diagnosis diagnosis) =>
      AddHistoryRecordBloc.allowDiagnosisSelection(healthStatus) &&
      diagnosis != null;

  static bool canSaveState(AddHistoryRecordState state) {
    if (state.cage == null || state.healthStatus == null) {
      return false;
    }

    if (state.healthStatus == HealthStates.deceased ||
        state.healthStatus == HealthStates.healthy) {
      return true;
    }

    if (state.healthStatus == HealthStates.suspicious &&
        state.diagnosis != null) {
      return true;
    }

    if (state.healthStatus == HealthStates.ill &&
        state.diagnosis != null &&
        state.treatment != null) {
      return true;
    }

    return false;
  }
}
