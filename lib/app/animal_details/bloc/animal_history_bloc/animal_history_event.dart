import 'package:livestock_repository/livestock_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

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
  final List<AnimalHistoryRecord> history;

  const HistoryChanged({@required this.animalNumber, @required this.history});

  @override
  List<Object> get props => [animalNumber, history];
}
