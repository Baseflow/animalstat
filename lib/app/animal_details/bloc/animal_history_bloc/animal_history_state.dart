import 'package:livestock_repository/livestock_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


abstract class AnimalHistoryState extends Equatable {
  const AnimalHistoryState();
}

class InitialHistoryState extends AnimalHistoryState {
  final int animalNumber;

  const InitialHistoryState({@required this.animalNumber});

  @override
  List<Object> get props => [animalNumber];
}

class LoadingHistory extends AnimalHistoryState {
  final int animalNumber;

  LoadingHistory({@required this.animalNumber});

  @override
  List<Object> get props => [animalNumber];
}

class HistoryUpdated extends AnimalHistoryState {
  final int animalNumber;
  final List<AnimalHistoryRecord> history;

  HistoryUpdated({@required this.animalNumber, @required this.history});

  @override
  List<Object> get props => [animalNumber, history,];
}

class NoHistory extends AnimalHistoryState {
  final int animalNumber;

  NoHistory({@required this.animalNumber});

  @override
  List<Object> get props => [animalNumber];
}