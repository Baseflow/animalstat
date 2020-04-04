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
      final openTreatments = _filterByState(
        recurringTreatments,
        TreatmentStates.unknown,
      );
      final appliedTreatments = _filterByState(
        recurringTreatments,
        TreatmentStates.done,
      );
      final cancelledTreatments = _filterByState(
        recurringTreatments,
        TreatmentStates.cancelled,
      );

      add(TreatmentsUpdated(
        openTreatments: openTreatments,
        appliedTreatments: appliedTreatments,
        cancelledTreatments: cancelledTreatments,
      ));
    });
  }

  Stream<RecurringTreatmentsState> _mapTreatmentsUpdatedToState(
    TreatmentsUpdated event,
  ) async* {
    yield state.copyWith(
      isLoading: false,
      openTreatments: event.openTreatments,
      appliedTreatments: event.appliedTreatments,
      cancelledTreatments: event.cancelledTreatments,
    );
  }

  List<RecurringTreatmentCardState> _filterByState(
    List<RecurringTreatment> treatments,
    TreatmentStates status,
  ) {
    if (treatments == null) {
      return <RecurringTreatmentCardState>[];
    }

    return treatments.where((t) => t.treatmentStatus == status).map((t) {
      return RecurringTreatmentCardState(
        recurringTreatmentId: t.id,
        animalNumber: t.animalNumber,
        cage: t.cageNumber,
        diagnosis: t.diagnosis,
        healthStatus: t.healthStatus,
        treatment: t.treatment,
      );
    }).toList();
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
