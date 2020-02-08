import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:livestock_repository/livestock_repository.dart';

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
  SearchAnimalState get initialState => SearchAnimalState.empty();

  @override
  Stream<SearchAnimalState> mapEventToState(
    SearchAnimalEvent event,
  ) async* {
    if (event is QueryChanged) {
      yield* _mapQueryChangedToState(event);
    } else if (event is ResultsChanged) {
      yield* _mapResultsChangedToState(event);
    }
  }

  Stream<SearchAnimalState> _mapQueryChangedToState(QueryChanged event) async* {
    if(event.query.length == 0) {
      yield SearchAnimalState.empty();
      return;
    }
    
    var animalNumber = int.tryParse(event.query);

    if (animalNumber == null) {
      yield SearchAnimalState.invalidQuery(event.query);
    }

    _animalSearchResultSubscription?.cancel();
    _animalSearchResultSubscription =
        _animalRepository.searchAnimals(animalNumber).listen(
              (searchResult) => add(
                ResultsChanged(
                  query: event.query,
                  results: searchResult,
                ),
              ),
            );
  }

  Stream<SearchAnimalState> _mapResultsChangedToState(
      ResultsChanged event) async* {
    yield state.update(
      query: event.query,
      searchResults: event.results,
    );
  }

  @override
  Future<void> close() {
    _animalSearchResultSubscription?.cancel();
    return super.close();
  }
}
