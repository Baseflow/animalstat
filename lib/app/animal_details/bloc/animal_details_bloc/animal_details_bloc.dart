import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:animalstat_repository/animalstat_repository.dart';
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
  AnimalDetailsState get initialState => AnimalDetailsState.loading(
        _animalNumber,
      );

  @override
  Stream<AnimalDetailsState> mapEventToState(
    AnimalDetailsEvent event,
  ) async* {
    if (event is LoadAnimalDetails) {
      yield* _mapLoadAnimalDetailsToState(event);
    } else if (event is AnimalChanged) {
      yield* _mapAnimalChangedToState(event);
    } else if (event is UpdateDetails) {
      yield* _mapUpdateDetailsToState(event);
    }
  }

  Stream<AnimalDetailsState> _mapLoadAnimalDetailsToState(
      LoadAnimalDetails event) async* {
    yield AnimalDetailsState.loading(event.animalNumber);

    _animalDetailSubscription?.cancel();
    _animalDetailSubscription = _animalRepository
        .findAnimalByNumber(event.animalNumber)
        .listen(
            (animalDetail) => add(AnimalChanged(animal: animalDetail)));
  }

  Stream<AnimalDetailsState> _mapAnimalChangedToState(
      AnimalChanged event) async* {
    yield state.update(event.animal);
  }

  Stream<AnimalDetailsState> _mapUpdateDetailsToState(
    UpdateDetails event,
  ) async* {
    yield state.copyWith(
      cage: event.cage,
      currentHealthStatus: event.currentHealthStatus,
      dateOfBirth: event.dateOfBirth,
    );
  }

  @override
  Future<void> close() {
    _animalDetailSubscription?.cancel();
    return super.close();
  }
}
