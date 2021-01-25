import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/animal_overview_item.dart';

abstract class AnimalDetailsEvent extends Equatable {
  const AnimalDetailsEvent({@required this.animalNumber})
      : assert(animalNumber != null);

  final int animalNumber;

  @override
  List<Object> get props => [animalNumber];
}

class LoadDetails extends AnimalDetailsEvent {
  const LoadDetails({int animalNumber}) : super(animalNumber: animalNumber);
}

class DetailsUpdated extends AnimalDetailsEvent {
  const DetailsUpdated({
    int animalNumber,
    this.currentCage,
    this.overviewItems,
  }) : super(animalNumber: animalNumber);

  final int currentCage;
  final List<AnimalOverviewItem> overviewItems;

  @override
  List<Object> get props => super.props
    ..addAll([
      currentCage,
      overviewItems,
    ]);
}
