import 'package:livestock_repository/livestock_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AnimalHistoryState extends Equatable {
  const AnimalHistoryState(this.animalNumber);

  final int animalNumber;
}

class InitialHistoryState extends AnimalHistoryState {
  const InitialHistoryState({@required int animalNumber}) : super(animalNumber);

  @override
  List<Object> get props => [animalNumber];
}

class LoadingHistory extends AnimalHistoryState {
  LoadingHistory({@required int animalNumber}) : super(animalNumber);

  @override
  List<Object> get props => [animalNumber];
}

class HistoryUpdated extends AnimalHistoryState {
  final List<AnimalHistoryRecord> history;

  HistoryUpdated({@required int animalNumber, @required this.history})
      : super(animalNumber);

  @override
  List<Object> get props => [
        animalNumber,
        history,
      ];
}

class NoHistory extends AnimalHistoryState {
  NoHistory({@required int animalNumber}) : super(animalNumber);

  @override
  List<Object> get props => [animalNumber];
}
