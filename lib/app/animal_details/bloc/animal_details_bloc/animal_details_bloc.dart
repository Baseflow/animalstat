import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:livestock_repository/livestock_repository.dart';
import 'package:livestock/app/animal_details/bloc/view_models/animal_detail_view_model.dart';
import 'package:meta/meta.dart';
import '../bloc.dart';

class AnimalDetailsBloc extends Bloc<AnimalDetailsEvent, AnimalDetailsState> {
  final int _animalNumber;
  final AnimalRepository _animalRepository;

  StreamSubscription _animalDetailSubscription;

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
    } else if (event is AnimalDetailsChanged) {
      yield* _mapAnimalDetailsChangedToState(event);
    }
  }

  Stream<AnimalDetailsState> _mapLoadAnimalDetailsToState(
      LoadAnimalDetails event) async* {
    yield AnimalDetailsLoading(animalNumber: event.animalNumber);

    _animalDetailSubscription?.cancel();
    _animalDetailSubscription = _animalRepository
        .loadAnimalByNumber(event.animalNumber)
        .listen(
            (animalDetail) => add(AnimalDetailsChanged(animal: animalDetail)));
  }

  Stream<AnimalDetailsState> _mapAnimalDetailsChangedToState(
      AnimalDetailsChanged event) async* {
    final animalViewModel = AnimalDetailsViewModel.fromModel(event.animal);
    yield AnimalDetailsLoaded(animal: animalViewModel);
  }
}
