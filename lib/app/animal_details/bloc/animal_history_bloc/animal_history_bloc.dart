import 'dart:async';
import 'package:livestock_repository/livestock_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../bloc.dart';

class AnimalHistoryBloc extends Bloc<AnimalHistoryEvent, AnimalHistoryState> {
  final int _animalNumber;
  final AnimalRepository _animalRepository;

  StreamSubscription _animalHistoryRecordsSubscription;

  AnimalHistoryBloc({
    @required int animalNumber,
    @required AnimalRepository animalRepository,
  })  : assert(animalRepository != null),
        this._animalNumber = animalNumber,
        this._animalRepository = animalRepository;

  @override
  AnimalHistoryState get initialState => InitialHistoryState(
        animalNumber: _animalNumber,
      );

  @override
  Stream<AnimalHistoryState> mapEventToState(
    AnimalHistoryEvent event,
  ) async* {
    if (event is LoadHistory) {
      yield* _mapLoadHistoryToState(event);
    } else if (event is HistoryChanged) {
      yield* _mapHistoryUpdatedToState(event);
    }
  }

  Stream<AnimalHistoryState> _mapLoadHistoryToState(LoadHistory event) async* {
    var animalNumber = event.animalNumber;
    yield LoadingHistory(animalNumber: animalNumber);

    _animalHistoryRecordsSubscription?.cancel();
    _animalHistoryRecordsSubscription = _animalRepository
        .findAnimalHistory(animalNumber)
        .listen((historyRecords) {
          final historyCardStates = historyRecords.map((entity) {
            return AnimalHistoryCardState(
              animalNumber: animalNumber,
              cage: entity.cage,
              diagnosis: entity.diagnosis,
              healthStatus: entity.healthStatus,
              seenOn: entity.seenOn,
              treatment: entity.treatment,
            );
          }).toList();

          add(HistoryChanged(
            animalNumber: animalNumber, history: historyCardStates));
        });
  }

  Stream<AnimalHistoryState> _mapHistoryUpdatedToState(
      HistoryChanged event) async* {
    if (event.history == null || event.history.length == 0) {
      yield NoHistory(animalNumber: event.animalNumber);
    } else {
      yield HistoryUpdated(
          animalNumber: event.animalNumber, history: event.history);
    }
  }
}
