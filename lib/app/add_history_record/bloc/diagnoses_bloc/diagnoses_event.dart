part of 'diagnoses_bloc.dart';

abstract class DiagnosesEvent extends Equatable {
  const DiagnosesEvent();
}

class LoadDiagnoses extends DiagnosesEvent {
  const LoadDiagnoses();

  @override
  List<Object> get props => [];
}

class DiagnosesUpdated extends DiagnosesEvent {
  const DiagnosesUpdated({
    @required this.diagnoses,
  });

  final List<Diagnosis> diagnoses;

  @override
  List<Object> get props => [diagnoses];
}
