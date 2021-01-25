import 'package:animalstat_repository/animalstat_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SearchAnimalState extends Equatable {
  final bool isEmpty;
  final bool isInvalidQuery;
  final bool isSearching;
  final String query;
  final List<Animal> searchResults;

  bool get notFound => !isEmpty && !isInvalidQuery && searchResults.isEmpty;

  SearchAnimalState({
    @required this.isEmpty,
    @required this.isInvalidQuery,
    @required this.isSearching,
    @required this.query,
    @required this.searchResults,
  });

  factory SearchAnimalState.empty() {
    return SearchAnimalState(
      isEmpty: true,
      isInvalidQuery: false,
      isSearching: false,
      query: '',
      searchResults: <Animal>[],
    );
  }

  factory SearchAnimalState.invalidQuery(
    String query,
  ) {
    return SearchAnimalState(
      isEmpty: false,
      isInvalidQuery: true,
      isSearching: false,
      query: query,
      searchResults: <Animal>[],
    );
  }

  SearchAnimalState update({
    String query,
    List<Animal> searchResults,
  }) {
    return copyWith(
      isEmpty: query.isEmpty ?? true,
      query: query,
      searchResults: searchResults,
    );
  }

  SearchAnimalState copyWith({
    bool isEmpty,
    bool isQueryValid,
    bool isSearching,
    String query,
    List<Animal> searchResults,
  }) {
    return SearchAnimalState(
      isEmpty: isEmpty ?? this.isEmpty,
      isInvalidQuery: isQueryValid ?? isInvalidQuery,
      isSearching: isSearching ?? this.isSearching,
      query: query ?? this.query,
      searchResults: searchResults ?? this.searchResults,
    );
  }

  @override
  List<Object> get props => [
        isEmpty,
        isInvalidQuery,
        isSearching,
        query,
        searchResults,
      ];
}
