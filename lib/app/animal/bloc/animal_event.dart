import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AnimalEvent extends Equatable {
  const AnimalEvent();
}

class AnimalSelected extends AnimalEvent {
  final int animalId;

  const AnimalSelected({@required this.animalId});

  @override
  List<Object> get props => [animalId];
}
