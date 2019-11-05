import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AnimalEvent extends Equatable {
  const AnimalEvent();
}

class SelectAnimal extends AnimalEvent {
  final int animalId;

  const SelectAnimal({@required this.animalId});

  @override
  List<Object> get props => [animalId];
}
