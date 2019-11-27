import 'package:equatable/equatable.dart';
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
