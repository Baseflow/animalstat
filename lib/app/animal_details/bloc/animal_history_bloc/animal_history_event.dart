import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'animal_history_card_state.dart';

abstract class AnimalHistoryEvent extends Equatable {
  const AnimalHistoryEvent();
}

class LoadHistory extends AnimalHistoryEvent {
  final int animalNumber;

  const LoadHistory({@required this.animalNumber});

  @override
  List<Object> get props => [animalNumber];
}

class HistoryChanged extends AnimalHistoryEvent {
  final int animalNumber;
  final List<AnimalHistoryCardState> history;

  const HistoryChanged({@required this.animalNumber, @required this.history});

  @override
  List<Object> get props => [animalNumber, history];
}
