import 'dart:async';
import 'package:animal_repository/animal_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import './bloc.dart';

class AnimalBloc extends Bloc<AnimalEvent, AnimalState> {
  final AnimalRepository _animalRepository;

  AnimalBloc({
    @required AnimalRepository animalRepository,
  })  : assert(animalRepository != null),
        this._animalRepository = animalRepository;

  @override
  AnimalState get initialState => InitialAnimalState();

  @override
  Stream<AnimalState> mapEventToState(
    AnimalEvent event,
  ) async* {
    if (event is SelectAnimal) {
      yield* _mapSelectAnimalToState(event);
    }
  }

  Stream<AnimalState> _mapSelectAnimalToState(SelectAnimal event) async* {
    yield AnimalChanged(animalId: event.animalId);

    var animal = await _animalRepository.loadAnimalByNumber(event.animalId);

    yield AnimalLoaded(animal: animal);
  }
}
