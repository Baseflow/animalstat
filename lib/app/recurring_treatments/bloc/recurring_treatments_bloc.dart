import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:livestock_repository/livestock_repository.dart';
import 'package:meta/meta.dart';

import '../../../src/extensions/date_time_extensions.dart';

part 'recurring_treatments_event.dart';
part 'recurring_treatments_state.dart';
part 'recurring_treatment_card_state.dart';

class RecurringTreatmentsBloc
    extends Bloc<RecurringTreatmentsEvent, RecurringTreatmentsState> {
  final RecurringTreatmentsRepository _recurringTreatmentsRepository;

  StreamSubscription _recurringTreatmentsSubscription;

  RecurringTreatmentsBloc({
    @required RecurringTreatmentsRepository recurringTreatmentsRepository,
  })  : assert(recurringTreatmentsRepository != null),
        _recurringTreatmentsRepository = recurringTreatmentsRepository;

  @override
  RecurringTreatmentsState get initialState =>
      RecurringTreatmentsState.initial();

  @override
  Stream<RecurringTreatmentsState> mapEventToState(
    RecurringTreatmentsEvent event,
  ) async* {
    if (event is SelectedDateChanged) {
      yield RecurringTreatmentsState.loading(event.selectedDate);
      add(LoadTreatments(selectedDate: state.selectedDate));
    } else if (event is LoadTreatments) {
      yield* _mapLoadTreatmentsToState(event);
    } else if (event is TreatmentsUpdated) {
      yield* _mapTreatmentsUpdatedToState(event);
    } else if (event is UpdateTreatment) {
      yield* _mapUpdateTreatmentToState(event);
    }
  }

  Stream<RecurringTreatmentsState> _mapLoadTreatmentsToState(
      LoadTreatments event) async* {
    yield RecurringTreatmentsState.loading(event.selectedDate);

    _recurringTreatmentsSubscription?.cancel();
    _recurringTreatmentsSubscription = _recurringTreatmentsRepository
        .findRecurringTreatmentsForDate(event.selectedDate)
        .listen((recurringTreatments) {
      final recurringTreatmentCardStates = recurringTreatments.map((entity) {
        return RecurringTreatmentCardState(
          recurringTreatmentId: entity.id,
          animalNumber: entity.animalNumber,
          cage: entity.cageNumber,
          diagnosis: entity.diagnosis,
          healthStatus: entity.healthStatus,
          treatment: entity.treatment,
        );
      }).toList();

      add(TreatmentsUpdated(treatments: recurringTreatmentCardStates));
    });
  }

  Stream<RecurringTreatmentsState> _mapTreatmentsUpdatedToState(
    TreatmentsUpdated event,
  ) async* {
    yield state.copyWith(
      isLoading: false,
      treatments: event.treatments ?? <RecurringTreatmentCardState>[],
    );
  }

  Stream<RecurringTreatmentsState> _mapUpdateTreatmentToState(
    UpdateTreatment event,
  ) async* {
    yield RecurringTreatmentsState.loading(state.selectedDate);

    await _recurringTreatmentsRepository.updateStatus(
      event.cardState.recurringTreatmentId,
      event.treatmentStatus,
    );

    add(LoadTreatments(selectedDate: state.selectedDate));
  }
}
