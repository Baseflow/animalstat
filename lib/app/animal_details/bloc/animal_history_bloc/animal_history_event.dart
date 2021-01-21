import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/animal_overview_item.dart';

abstract class AnimalHistoryEvent extends Equatable {
  const AnimalHistoryEvent({
    @required this.animalNumber,
  }) : assert(animalNumber != null);

  final int animalNumber;

  @override
  List<Object> get props => [animalNumber];
}

class LoadHistory extends AnimalHistoryEvent {
  const LoadHistory({
    @required int animalNumber,
  }) : super(animalNumber: animalNumber);

  @override
  List<Object> get props => super.props;
}

class HistoryUpdated extends AnimalHistoryEvent {
  const HistoryUpdated({
    @required int animalNumber,
    @required this.history,
  }) : super(animalNumber: animalNumber);

  final List<AnimalOverviewItem> history;

  @override
  List<Object> get props => super.props
    ..addAll([
      history,
    ]);
}
