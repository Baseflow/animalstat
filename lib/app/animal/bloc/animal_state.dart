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
  final int animalId;

  const AnimalChanged({@required this.animalId});

  @override
  List<Object> get props => [animalId];
}