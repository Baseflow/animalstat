import 'dart:async';

import 'package:animalstat/src/utilities/enum_converters.dart';
import 'package:animalstat_repository/animalstat_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import '../../../../src/extensions/iterables_extensions.dart';
import '../../models/animal_overview_item.dart';
import '../bloc.dart';

class AnimalHistoryBloc extends Bloc<AnimalHistoryEvent, AnimalHistoryState> {
  final AnimalRepository _animalRepository;

  StreamSubscription _animalDetailsSubscription;
  StreamSubscription _animalHistorySubscription;

  AnimalHistoryBloc({
    @required int animalNumber,
    @required AnimalRepository animalRepository,
  })  : assert(animalRepository != null),
        _animalRepository = animalRepository,
        super(AnimalHistoryState.initial(animalNumber: animalNumber));

  @override
  Stream<AnimalHistoryState> mapEventToState(
    AnimalHistoryEvent event,
  ) async* {
    if (event is LoadHistory) {
      yield* _mapLoadHistoryToState(event);
    } else if (event is HistoryUpdated) {
      yield* _mapHistoryUpdatedToState(event);
    }
  }

  Stream<AnimalHistoryState> _mapLoadHistoryToState(LoadHistory event) async* {
    var animalNumber = event.animalNumber;
    yield AnimalHistoryState.loading(animalNumber: animalNumber);

    _animalHistorySubscription?.cancel();
    _animalHistorySubscription = _animalRepository
        .findAnimalHistory(animalNumber)
        .listen((historyRecords) {
      final overviewItems = _groupHistoryRecords(historyRecords);
      add(HistoryUpdated(
        animalNumber: animalNumber,
        history: overviewItems,
      ));
    });
  }

  List<AnimalOverviewItem> _groupHistoryRecords(
    List<AnimalHistoryRecord> historyRecords,
  ) {
    final groupedRecords = historyRecords.groupBy((item) => item.seenOn);
    final overviewItems = <AnimalOverviewItem>[];

    overviewItems.add(AnimalOverviewHeader(
      overviewItemType: AnimalOverviewItemTypes.header,
      title: 'Registraties',
    ));

    for (final key in groupedRecords.keys) {
      overviewItems.add(AnimalOverviewHeader(
        overviewItemType: AnimalOverviewItemTypes.subHeader,
        title: DateFormat.yMMMMd().format(key),
      ));

      overviewItems
          .addAll(groupedRecords[key].map((record) => AnimalOverviewCard(
                title: 'Hok: ${record.cage}',
                subtitle:
                    EnumConverters.toDiagnosesDisplayValue(record.diagnosis),
                text: EnumConverters.toTreatmentDisplayValue(record.treatment),
                healthStatus: record.healthStatus,
              )));
    }

    return overviewItems;
  }

  Stream<AnimalHistoryState> _mapHistoryUpdatedToState(
      HistoryUpdated event) async* {
    yield state.copyWith(
      animalNumber: event.animalNumber,
      isLoading: false,
      overviewItems: event.history,
    );
  }
}
