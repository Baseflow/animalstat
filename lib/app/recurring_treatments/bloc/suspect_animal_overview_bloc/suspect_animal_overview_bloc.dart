import 'dart:async';

import 'package:animalstat_repository/animalstat_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../src/extensions/iterables_extensions.dart';
import '../models/models.dart';

part 'suspect_animal_overview_event.dart';
part 'suspect_animal_overview_state.dart';

class SuspectAnimalOverviewBloc
    extends Bloc<SuspectAnimalOverviewEvent, SuspectAnimalOverviewState> {
  final AnimalRepository _animalRepositoy;
  final User _user;

  StreamSubscription _diagnosesSubscription;

  SuspectAnimalOverviewBloc({
    @required AnimalRepository animalRepository,
    @required User user,
  })  : assert(animalRepository != null),
        assert(user != null),
        _animalRepositoy = animalRepository,
        _user = user,
        super(SuspectAnimalOverviewState.initial()) {
    add(const LoadAnimals());
  }

  @override
  void onEvent(SuspectAnimalOverviewEvent event) {
    super.onEvent(event);

    if (event is SaveAnimal) {
      _saveAnimalHealthRecord(event);
    }
  }

  @override
  Stream<SuspectAnimalOverviewState> mapEventToState(
    SuspectAnimalOverviewEvent event,
  ) async* {
    if (event is LoadAnimals) {
      yield* _mapLoadAnimalsToState(event);
    } else if (event is AnimalsUpdated) {
      yield* _mapAnimalsUpdatedToState(event);
    }
  }

  Stream<SuspectAnimalOverviewState> _mapLoadAnimalsToState(
      LoadAnimals event) async* {
    yield SuspectAnimalOverviewState.loading();

    _diagnosesSubscription?.cancel();
    _diagnosesSubscription =
        _animalRepositoy.findSuspectAnimals().listen((animals) {
      final treatmentCards = animals
          .map(
            (animal) => TreatmentCard(
                animalNumber: animal.animalNumber,
                cage: animal.currentCageNumber,
                healthStatus: animal.healthInfo?.healthStatus,
                diagnosis: animal.healthInfo?.diagnosis),
          )
          .toList();
      final groupedItems = _groupTreatmentCards(treatmentCards);

      add(AnimalsUpdated(
        treatmentListItems: groupedItems,
      ));
    });
  }

  Stream<SuspectAnimalOverviewState> _mapAnimalsUpdatedToState(
      AnimalsUpdated event) async* {
    yield state.copyWith(
      treatmentListItems: event.treatmentListItems,
      isLoading: false,
    );
  }

  List<TreatmentListItem> _groupTreatmentCards(
    List<TreatmentCard> treatmentCards,
  ) {
    final groupedRecords = treatmentCards.groupBy((item) => item.cage);
    final overviewItems = <TreatmentListItem>[];

    for (final key in groupedRecords.keys) {
      overviewItems
          .add(TreatmentListItem(TreatmentListItemTypes.header, key, null));

      overviewItems
          .addAll(groupedRecords[key].map((record) => TreatmentListItem(
                TreatmentListItemTypes.card,
                key,
                record,
              )));
    }

    return overviewItems;
  }

  Future<void> _saveAnimalHealthRecord(SaveAnimal event) async {
    final userInfo = UserInfo(
      _user.id,
      _user.email,
    );

    final historyRecord = AnimalHistoryRecord(
      event.cage,
      null,
      HealthStates.healthy,
      userInfo,
      DateTime.now(),
      null,
      DateTime.now(),
    );

    await _animalRepositoy.insertHistoryRecord(
        event.animalNumber, historyRecord);
  }

  @override
  Future<void> close() {
    _diagnosesSubscription?.cancel();
    return super.close();
  }
}
