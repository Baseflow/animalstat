import 'package:equatable/equatable.dart';
import 'package:livestock/app/animal_details/bloc/view_models/animal_detail_view_model.dart';
import 'package:meta/meta.dart';

abstract class AnimalDetailsState extends Equatable {
  final int animalNumber;

  const AnimalDetailsState(this.animalNumber);

  @override
  List<Object> get props => [animalNumber];
}

class InitialAnimalDetailsState extends AnimalDetailsState {
  const InitialAnimalDetailsState({@required int animalNumber})
    : super(animalNumber);
}

class AnimalDetailsLoading extends AnimalDetailsState {
  const AnimalDetailsLoading({@required int animalNumber})
      : super(animalNumber);
}

class AnimalDetailsLoaded extends AnimalDetailsState {
  final AnimalDetailsViewModel animal;

  AnimalDetailsLoaded({@required this.animal})
    : super(animal.animalNumber);

  @override
  List<Object> get props => [animal];
}
