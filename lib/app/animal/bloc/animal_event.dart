import 'package:animal_repository/animal_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AnimalEvent extends Equatable {
  const AnimalEvent();
}

class SelectAnimal extends AnimalEvent {
  final int animalNumber;

  const SelectAnimal({@required this.animalNumber});

  @override
  List<Object> get props => [animalNumber];
}

class HistoryChanged extends AnimalEvent {
  final Animal animal;
  final List<AnimalHistoryRecord> history;

  const HistoryChanged({@required this.animal, @required this.history});

  @override
  List<Object> get props => [animal, history];
}
