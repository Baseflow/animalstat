import 'package:equatable/equatable.dart';

import '../../models/animal_overview_item.dart';

class AnimalHistoryState extends Equatable {
  const AnimalHistoryState({
    this.animalNumber,
    this.isLoading,
    this.overviewItems,
  });

  final int animalNumber;
  final bool isLoading;
  final List<AnimalOverviewItem> overviewItems;

  bool get isEmpty => overviewItems == null || overviewItems.isEmpty;

  @override
  List<Object> get props => [
        animalNumber,
        isLoading,
        overviewItems,
      ];

  factory AnimalHistoryState.initial({
    int animalNumber,
  }) {
    return AnimalHistoryState(
      animalNumber: animalNumber,
      isLoading: false,
      overviewItems: null,
    );
  }

  factory AnimalHistoryState.loading({
    int animalNumber,
  }) {
    return AnimalHistoryState(
      animalNumber: animalNumber,
      isLoading: true,
      overviewItems: null,
    );
  }

  AnimalHistoryState copyWith({
    int animalNumber,
    bool isLoading,
    List<AnimalOverviewItem> overviewItems,
  }) {
    return AnimalHistoryState(
      animalNumber: animalNumber ?? this.animalNumber,
      isLoading: isLoading ?? this.isLoading,
      overviewItems: overviewItems ?? this.overviewItems,
    );
  }
}
