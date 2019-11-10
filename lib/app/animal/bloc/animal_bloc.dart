import 'dart:async';
import 'package:animal_repository/animal_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import './bloc.dart';

class AnimalBloc extends Bloc<AnimalEvent, AnimalState> {
  final AnimalRepository _animalRepository;

  StreamSubscription _animalHistoryRecordsSubscription;

  AnimalBloc({
    @required AnimalRepository animalRepository,
  })  : assert(animalRepository != null),
        this._animalRepository = animalRepository;

  @override
  AnimalState get initialState => InitialAnimalState();

  @override
  Stream<AnimalState> mapEventToState(
    AnimalEvent event,
  ) async* {
    if (event is SelectAnimal) {
      yield* _mapSelectAnimalToState(event);
    } else if (event is HistoryChanged) {
      yield* _mapHistoryChangedToState(event);
    }
  }

  Stream<AnimalState> _mapSelectAnimalToState(SelectAnimal event) async* {
    yield AnimalChanged(animalNumber: event.animalNumber);

    var animal = await _animalRepository.loadAnimalByNumber(event.animalNumber);

    _animalHistoryRecordsSubscription?.cancel();
    _animalHistoryRecordsSubscription = _animalRepository
        .animalHistory(event.animalNumber)
        .listen((historyRecords) =>
            add(HistoryChanged(animal: animal, history: historyRecords)));
  }

  Stream<AnimalState> _mapHistoryChangedToState(HistoryChanged event) async* {
    if (event.history == null || event.history.length == 0) {
      yield NoHistory(animal: event.animal);
    } else {
      yield HistoryUpdated(animal: event.animal, history: event.history);
    }
  }
}
