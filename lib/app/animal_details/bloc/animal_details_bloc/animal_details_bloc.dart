import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:animal_repository/animal_repository.dart';
import 'package:livestock/app/animal_details/bloc/view_models/animal_detail_view_model.dart';
import 'package:meta/meta.dart';
import '../bloc.dart';

class AnimalDetailsBloc extends Bloc<AnimalDetailsEvent, AnimalDetailsState> {
  final int _animalNumber;
  final AnimalRepository _animalRepository;

  AnimalDetailsBloc({
    @required int animalNumber,
    @required AnimalRepository animalRepository,
  })  : assert(animalRepository != null),
        this._animalNumber = animalNumber,
        this._animalRepository = animalRepository;

  @override
  AnimalDetailsState get initialState => InitialAnimalDetailsState(
        animalNumber: _animalNumber,
      );

  @override
  Stream<AnimalDetailsState> mapEventToState(
    AnimalDetailsEvent event,
  ) async* {
    if (event is LoadAnimalDetails) {
      yield* _mapLoadAnimalDetailsToState(event);
    }
  }

  Stream<AnimalDetailsState> _mapLoadAnimalDetailsToState(
      LoadAnimalDetails event) async* {
    yield AnimalDetailsLoading();

    var animal = await _animalRepository.loadAnimalByNumber(event.animalNumber);

    yield AnimalDetailsLoaded(animal: AnimalDetailsViewModel.fromModel(animal));
  }
}
