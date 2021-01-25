part of 'suspect_animal_overview_bloc.dart';

@immutable
abstract class SuspectAnimalOverviewEvent extends Equatable {
  const SuspectAnimalOverviewEvent();
}

class LoadAnimals extends SuspectAnimalOverviewEvent {
  const LoadAnimals();

  @override
  List<Object> get props => [];
}

class AnimalsUpdated extends SuspectAnimalOverviewEvent {
  const AnimalsUpdated({
    @required this.treatmentListItems,
  });

  final List<TreatmentListItem> treatmentListItems;

  @override
  List<Object> get props => [treatmentListItems];
}
