import 'dart:async';

import 'package:animalstat_repository/animalstat_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../src/extensions/date_time_extensions.dart';
import '../../../../src/extensions/iterables_extensions.dart';
import '../models/models.dart';

part 'recurring_treatments_event.dart';
part 'recurring_treatments_state.dart';

class RecurringTreatmentsBloc
    extends Bloc<RecurringTreatmentsEvent, RecurringTreatmentsState> {
  final RecurringTreatmentsRepository _recurringTreatmentsRepository;

  StreamSubscription _recurringTreatmentsSubscription;

  RecurringTreatmentsBloc({
    @required RecurringTreatmentsRepository recurringTreatmentsRepository,
  })  : assert(recurringTreatmentsRepository != null),
        _recurringTreatmentsRepository = recurringTreatmentsRepository,
        super(RecurringTreatmentsState.initial()) {
    add(LoadTreatments(
      selectedDate: DateTime.now().toDate(),
    ));
  }

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

  List<TreatmentListItem> _filterByState(
    List<RecurringTreatment> treatments,
    TreatmentStates status,
  ) {
    if (treatments == null) {
      return <TreatmentListItem>[];
    }

    final filteredTreatments =
        treatments.where((t) => t.treatmentStatus == status).map((t) {
      return TreatmentCard(
        recurringTreatmentId: t.id,
        animalNumber: t.animalNumber,
        cage: t.cageNumber,
        diagnosis: t.diagnosis?.name,
        healthStatus: t.healthStatus,
        treatment: t.treatment?.name,
      );
    }).toList();

    final groupedTreatments = filteredTreatments.groupBy((item) => item.cage);
    final recurringTreatmentList = <TreatmentListItem>[];
    for (final key in groupedTreatments.keys) {
      recurringTreatmentList
          .add(TreatmentListItem(TreatmentListItemTypes.header, key, null));
      recurringTreatmentList.addAll(groupedTreatments[key].map(
          (card) => TreatmentListItem(TreatmentListItemTypes.card, key, card)));
    }

    return recurringTreatmentList;
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

  @override
  Future<void> close() {
    _recurringTreatmentsSubscription?.cancel();
    return super.close();
  }
}
