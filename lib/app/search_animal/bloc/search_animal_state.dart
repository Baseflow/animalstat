import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:animal_repository/animal_repository.dart';

abstract class SearchAnimalState extends Equatable {
  const SearchAnimalState();
}

class InitialSearchState extends SearchAnimalState {
  @override
  List<Object> get props => [];
}

class InvalidQueryState extends SearchAnimalState {
  final String query;

  const InvalidQueryState({@required this.query});

  @override
  List<Object> get props => [query];

  @override
  String toString() => 'InvalidQueryState { query: $query }';
}

class ResultsUpdatedState extends SearchAnimalState {
  final List<AnimalSearchResult> searchResults;

  const ResultsUpdatedState({@required this.searchResults});

  List<Object> get props => [searchResults];

  @override
  String toString() => 'SearchResultsUpdated { searchResults: $searchResults }';
}
