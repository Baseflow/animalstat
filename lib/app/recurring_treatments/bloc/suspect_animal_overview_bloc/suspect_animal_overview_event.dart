part of 'suspect_animal_overview_bloc.dart';

@immutable
abstract class SuspectAnimalOverviewEvent extends Equatable {
  const SuspectAnimalOverviewEvent();
}

class LoadAnimals extends SuspectAnimalOverviewEvent {
  const LoadAnimals();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class AnimalsUpdated extends SuspectAnimalOverviewEvent {
  const AnimalsUpdated({
    @required this.treatmentListItems,
  });

  final List<TreatmentListItem> treatmentListItems;

  @override
  List<Object> get props => [treatmentListItems];

  @override
  bool get stringify => true;
}

class SaveAnimal extends SuspectAnimalOverviewEvent {
  const SaveAnimal({
    @required this.animalNumber,
    @required this.cage,
  })  : assert(animalNumber != null),
        assert(cage != null);

  final int animalNumber;
  final int cage;

  @override
  List<Object> get props => [animalNumber, cage];

  @override
  bool get stringify => true;
}
