import 'package:equatable/equatable.dart';
import 'package:livestock_repository/livestock_repository.dart';
import 'package:meta/meta.dart';

abstract class AnimalDetailsEvent extends Equatable {
  const AnimalDetailsEvent();
}

class LoadAnimalDetails extends AnimalDetailsEvent {
  final int animalNumber;

  const LoadAnimalDetails({@required this.animalNumber});

  @override
  List<Object> get props => [animalNumber];
}

class AnimalDetailsChanged extends AnimalDetailsEvent {
  AnimalDetailsChanged({@required this.animal});
  
  final Animal animal;
  
  @override
  List<Object> get props => [animal];
}