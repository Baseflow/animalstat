import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class AnimalBloc extends Bloc<AnimalEvent, AnimalState> {
  @override
  AnimalState get initialState => InitialAnimalState();

  @override
  Stream<AnimalState> mapEventToState(
    AnimalEvent event,
  ) async* {
    if(event is AnimalSelected) {
      yield AnimalChanged(animalId: event.animalId);
    }
  }
}
