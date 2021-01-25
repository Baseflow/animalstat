import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/animal_overview_item.dart';

class AnimalDetailsState extends Equatable {
  const AnimalDetailsState({
    @required this.animalNumber,
    @required this.currentCage,
    @required this.overviewItems,
    @required this.isLoading,
  });

  final int animalNumber;
  final int currentCage;
  final List<AnimalOverviewItem> overviewItems;
  final bool isLoading;

  bool get isEmpty => overviewItems == null || overviewItems.isEmpty;

  factory AnimalDetailsState.initial(int animalNumber) {
    return AnimalDetailsState(
      animalNumber: animalNumber,
      currentCage: null,
      overviewItems: null,
      isLoading: false,
    );
  }

  factory AnimalDetailsState.loading(int animalNumber) {
    return AnimalDetailsState(
      animalNumber: animalNumber,
      currentCage: null,
      overviewItems: null,
      isLoading: true,
    );
  }

  AnimalDetailsState copyWith({
    int animalNumber,
    int currentCage,
    List<AnimalOverviewItem> overviewItems,
    bool isLoading,
  }) {
    return AnimalDetailsState(
      animalNumber: animalNumber ?? this.animalNumber,
      currentCage: currentCage ?? this.currentCage,
      overviewItems: overviewItems ?? this.overviewItems,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [
        animalNumber,
        currentCage,
        overviewItems,
        isLoading,
      ];
}
