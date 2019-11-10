import 'package:animal_repository/animal_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


abstract class AnimalState extends Equatable {
  const AnimalState();
}

class InitialAnimalState extends AnimalState {
  @override
  List<Object> get props => [];
}

class AnimalChanged extends AnimalState {
  final int animalNumber;

  const AnimalChanged({@required this.animalNumber});

  @override
  List<Object> get props => [animalNumber];
}

class HistoryUpdated extends AnimalChanged {
  final Animal animal;
  final List<AnimalHistoryRecord> history;

  HistoryUpdated({@required this.animal, @required this.history})
      : super(animalNumber: animal.animalNumber);

  @override
  List<Object> get props => [animal, history,];
}

class NoHistory extends AnimalChanged {
  final Animal animal;

  NoHistory({@required this.animal})
      : super(animalNumber: animal.animalNumber);

  @override
  List<Object> get props => [animal];
}