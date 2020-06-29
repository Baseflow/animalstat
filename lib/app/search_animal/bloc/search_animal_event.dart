import 'package:animalstat_repository/animalstat_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SearchAnimalEvent extends Equatable {
  const SearchAnimalEvent();
}

class QueryChanged extends SearchAnimalEvent {
  final String query;

  const QueryChanged({@required this.query});

  @override
  List<Object> get props => [query];

  @override
  String toString() => 'QueryChanged { query: $query }';
}

class ResultsChanged extends SearchAnimalEvent {
  final String query;
  final List<Animal> results;

  const ResultsChanged({@required this.query, @required this.results});

  @override
  List<Object> get props => [results];

  String toString() => 'ResultsUpdated { results: $results }';
}