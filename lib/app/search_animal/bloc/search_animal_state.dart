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

class InvalidQuery extends SearchAnimalState {
  final String query;

  const InvalidQuery({@required this.query});

  @override
  List<Object> get props => [query];

  @override
  String toString() => 'InvalidQueryState { query: $query }';
}

class ResultsUpdated extends SearchAnimalState {
  final List<AnimalSearchResult> searchResults;

  const ResultsUpdated({@required this.searchResults});

  List<Object> get props => [searchResults];

  @override
  String toString() => 'SearchResultsUpdated { searchResults: $searchResults }';
}

class NotFound extends SearchAnimalState {
  @override
  List<Object> get props => [];

  @override
  String toString() =>  'NotFound';
}
