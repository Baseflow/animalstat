import 'dart:async';

import 'package:animalstat_repository/animalstat_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'diagnoses_event.dart';
part 'diagnoses_state.dart';

class DiagnosesBloc extends Bloc<DiagnosesEvent, DiagnosesState> {
  final DiagnosisRepository _diagnosisRepository;

  StreamSubscription _diagnosesSubscription;

  DiagnosesBloc({
    @required DiagnosisRepository diagnosisRepository,
  })  : assert(diagnosisRepository != null),
        _diagnosisRepository = diagnosisRepository,
        super(DiagnosesState.initial());

  @override
  Stream<DiagnosesState> mapEventToState(
    DiagnosesEvent event,
  ) async* {
    if (event is LoadDiagnoses) {
      yield* _mapLoadDiagnosesToState(event);
    } else if (event is DiagnosesUpdated) {
      yield* _mapDiagnosesUpdatedToState(event);
    }
  }

  Stream<DiagnosesState> _mapLoadDiagnosesToState(LoadDiagnoses event) async* {
    yield DiagnosesState.loading();

    _diagnosesSubscription?.cancel();
    _diagnosesSubscription =
        _diagnosisRepository.getDiagnoses().listen((diagnoses) {
      add(DiagnosesUpdated(
        diagnoses: diagnoses,
      ));
    });
  }

  Stream<DiagnosesState> _mapDiagnosesUpdatedToState(
      DiagnosesUpdated event) async* {
    yield state.copyWith(
      diagnoses: event.diagnoses,
      isLoading: false,
    );
  }

  @override
  Future<void> close() {
    _diagnosesSubscription?.cancel();
    return super.close();
  }
}
