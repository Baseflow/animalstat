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
  final int totalAnimalCount;
  final List<Animal> results;

  const ResultsChanged({
    @required this.query,
    @required this.results,
    @required this.totalAnimalCount,
  });

  @override
  List<Object> get props => [query, results, totalAnimalCount];

  String toString() => 'ResultsUpdated { results: $results }';
}
