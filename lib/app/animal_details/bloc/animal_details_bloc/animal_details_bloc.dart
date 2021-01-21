import 'dart:async';

import 'package:animalstat/app/animal_details/models/animal_overview_item.dart';
import 'package:animalstat_repository/animalstat_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import '../bloc.dart';

class AnimalDetailsBloc extends Bloc<AnimalDetailsEvent, AnimalDetailsState> {
  final AnimalRepository _animalRepository;

  StreamSubscription _animalDetailSubscription;

  AnimalDetailsBloc({
    @required int animalNumber,
    @required AnimalRepository animalRepository,
  })  : assert(animalRepository != null),
        _animalRepository = animalRepository,
        super(AnimalDetailsState.loading(animalNumber));

  @override
  Stream<AnimalDetailsState> mapEventToState(
    AnimalDetailsEvent event,
  ) async* {
    if (event is LoadDetails) {
      yield* _mapLoadDetailsToState(event);
    } else if (event is DetailsUpdated) {
      yield* _mapDetailsUpdatedToState(event);
    }
  }

  Stream<AnimalDetailsState> _mapLoadDetailsToState(LoadDetails event) async* {
    yield AnimalDetailsState.loading(event.animalNumber);

    _animalDetailSubscription?.cancel();
    _animalDetailSubscription = _animalRepository
        .findAnimalByNumber(event.animalNumber)
        .listen((animalDetail) {
      final overviewItems = <AnimalOverviewItem>[
        AnimalOverviewHeader(
          overviewItemType: AnimalOverviewItemTypes.header,
          title: 'Gegevens',
        ),
        AnimalOverviewCard(
          title: DateFormat.yMMMMd().format(animalDetail.dateOfBirth),
        ),
      ];

      add(DetailsUpdated(
        animalNumber: animalDetail.animalNumber,
        currentCage: animalDetail.currentCageNumber,
        overviewItems: overviewItems,
      ));
    });
  }

  Stream<AnimalDetailsState> _mapDetailsUpdatedToState(
    DetailsUpdated event,
  ) async* {
    yield state.copyWith(
      animalNumber: event.animalNumber,
      currentCage: event.currentCage,
      overviewItems: event.overviewItems,
      isLoading: false,
    );
  }

  @override
  Future<void> close() {
    _animalDetailSubscription?.cancel();
    return super.close();
  }
}
