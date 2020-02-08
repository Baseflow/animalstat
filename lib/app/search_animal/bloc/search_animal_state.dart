import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:livestock_repository/livestock_repository.dart';

class SearchAnimalState extends Equatable {
  final bool isEmpty;
  final bool isQueryValid;
  final bool isSearching;
  final String query;
  final List<AnimalSearchResult> searchResults;

  bool get notFound => !isEmpty && isQueryValid && searchResults.length == 0;
  bool get isNewAnimal => notFound && query.length == 5;

  SearchAnimalState({
    @required this.isEmpty,
    @required this.isQueryValid,
    @required this.isSearching,
    @required this.query,
    @required this.searchResults,
  });

  factory SearchAnimalState.empty() {
    return SearchAnimalState(
      isEmpty: true,
      isQueryValid: true,
      isSearching: false,
      query: '',
      searchResults: <AnimalSearchResult>[],
    );
  }

  factory SearchAnimalState.invalidQuery(
    String query,
  ) {
    return SearchAnimalState(
      isEmpty: false,
      isQueryValid: false,
      isSearching: false,
      query: query,
      searchResults: <AnimalSearchResult>[],
    );
  }

  SearchAnimalState update({
    String query,
    List<AnimalSearchResult> searchResults,
  }) {
    return copyWith(
      isEmpty: query?.length == 0 ?? true,
      query: query,
      searchResults: searchResults,
    );
  }

  SearchAnimalState copyWith({
    bool isEmpty,
    bool isQueryValid,
    bool isSearching,
    String query,
    List<AnimalSearchResult> searchResults,
  }) {
    return SearchAnimalState(
      isEmpty: isEmpty ?? this.isEmpty,
      isQueryValid: isQueryValid ?? this.isQueryValid,
      isSearching: isSearching ?? this.isSearching,
      query: query ?? this.query,
      searchResults: searchResults ?? this.searchResults,
    );
  }

  @override
  List<Object> get props => [
        isEmpty,
        isQueryValid,
        isSearching,
        query,
        searchResults,
      ];
}
