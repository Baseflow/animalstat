import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:animal_repository/animal_repository.dart';

import 'package:meta/meta.dart';
import './bloc.dart';

class SearchAnimalBloc extends Bloc<SearchAnimalEvent, SearchAnimalState> {
  final AnimalRepository _animalRepository;
  StreamSubscription _animalSearchResultSubscription;

  SearchAnimalBloc({
    @required AnimalRepository animalRepository,
  })  : assert(animalRepository != null),
        this._animalRepository = animalRepository;

  @override
  SearchAnimalState get initialState => InitialSearchState();

  @override
  Stream<SearchAnimalState> mapEventToState(
    SearchAnimalEvent event,
  ) async* {
    if (event is QueryChanged) {
      yield* _mapQueryChangedToState(event);
    } else if (event is ResultsChanged) {
      yield* _mapResultsUpdatedToState(event);
    }
  }

  Stream<SearchAnimalState> _mapQueryChangedToState(QueryChanged event) async* {
    var animalNumber = int.tryParse(event.query);

    if (animalNumber == null) {
      yield InvalidQuery(query: event.query);
    }

    _animalSearchResultSubscription?.cancel();
    _animalSearchResultSubscription = _animalRepository
        .searchAnimals(animalNumber)
        .listen((searchResult) => add(ResultsChanged(results: searchResult)));
  }

  Stream<SearchAnimalState> _mapResultsUpdatedToState(
      ResultsChanged event) async* {
    if (event.results == null || event.results.length == 0) {
      yield NotFound();
    } else {
      yield ResultsUpdated(searchResults: event.results);
    }
  }

  @override
  Future<void> close() {
    _animalSearchResultSubscription?.cancel();
    return super.close();
  }
}
