import 'dart:async';

import 'package:animalstat_repository/animalstat_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'treatments_event.dart';
part 'treatments_state.dart';

class TreatmentsBloc extends Bloc<TreatmentsEvent, TreatmentsState> {
  final TreatmentRepository _treatmentsRepository;

  StreamSubscription _treatmentsSubscription;

  TreatmentsBloc({
    @required TreatmentRepository treatmentRepository,
  })  : assert(treatmentRepository != null),
        _treatmentsRepository = treatmentRepository,
        super(TreatmentsState.initial());

  @override
  Stream<TreatmentsState> mapEventToState(
    TreatmentsEvent event,
  ) async* {
    if (event is LoadTreatments) {
      yield* _mapLoadTreatmentsToState(event);
    } else if (event is TreatmentsUpdated) {
      yield* _mapTreatmentsUpdatedToState(event);
    }
  }

  Stream<TreatmentsState> _mapLoadTreatmentsToState(
    LoadTreatments event,
  ) async* {
    yield TreatmentsState.loading();

    _treatmentsSubscription?.cancel();
    _treatmentsSubscription =
        _treatmentsRepository.getTreatments().listen((treatments) {
      final filteredTreatments = treatments
          .where((treatment) => treatment.diagnosisId == event.diagnosisId)
          .toList();

      add(TreatmentsUpdated(
        treatments: filteredTreatments,
      ));
    });
  }

  Stream<TreatmentsState> _mapTreatmentsUpdatedToState(
      TreatmentsUpdated event) async* {
    yield state.copyWith(
      treatments: event.treatments,
      isLoading: false,
    );
  }

  @override
  Future<void> close() {
    _treatmentsSubscription?.cancel();
    return super.close();
  }
}
