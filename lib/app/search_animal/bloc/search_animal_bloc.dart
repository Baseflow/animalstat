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
    } else if (event is ResultsUpdated) {
      yield* _mapResultsUpdatedToState(event);
    }
  }

  Stream<SearchAnimalState> _mapQueryChangedToState(QueryChanged event) async* {
    var animalNumber = int.tryParse(event.query);

    if (animalNumber == null) {
      yield InvalidQueryState(query: event.query);
    }

    _animalSearchResultSubscription?.cancel();
    _animalSearchResultSubscription = _animalRepository
        .searchAnimals(animalNumber)
        .listen((searchResult) => add(ResultsUpdated(results: searchResult)));
  }

  Stream<SearchAnimalState> _mapResultsUpdatedToState(
      ResultsUpdated event) async* {
    yield ResultsUpdatedState(searchResults: event.results);
  }

  @override
  void close() {
    _animalSearchResultSubscription?.cancel();
    super.close();
  }
}
