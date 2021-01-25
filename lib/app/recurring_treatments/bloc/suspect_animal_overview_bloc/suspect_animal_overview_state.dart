part of 'suspect_animal_overview_bloc.dart';

@immutable
class SuspectAnimalOverviewState extends Equatable {
  const SuspectAnimalOverviewState({
    @required this.treatmentListItems,
    @required this.isLoading,
  });

  final List<TreatmentListItem> treatmentListItems;
  final bool isLoading;

  bool get isEmpty => treatmentListItems == null || treatmentListItems.isEmpty;

  @override
  List<Object> get props => [
        treatmentListItems,
        isLoading,
      ];

  @override
  bool get stringify => true;

  factory SuspectAnimalOverviewState.initial() {
    return const SuspectAnimalOverviewState(
      treatmentListItems: null,
      isLoading: false,
    );
  }

  factory SuspectAnimalOverviewState.loading() {
    return const SuspectAnimalOverviewState(
      treatmentListItems: null,
      isLoading: true,
    );
  }

  SuspectAnimalOverviewState copyWith({
    List<TreatmentListItem> treatmentListItems,
    bool isLoading,
  }) {
    return SuspectAnimalOverviewState(
      treatmentListItems: treatmentListItems ?? this.treatmentListItems,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
