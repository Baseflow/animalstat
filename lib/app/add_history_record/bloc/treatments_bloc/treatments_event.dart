part of 'treatments_bloc.dart';

abstract class TreatmentsEvent extends Equatable {
  const TreatmentsEvent();
}

class LoadTreatments extends TreatmentsEvent {
  const LoadTreatments({@required this.diagnosisId})
      : assert(diagnosisId != null);

  final String diagnosisId;

  @override
  List<Object> get props => [diagnosisId];
}

class TreatmentsUpdated extends TreatmentsEvent {
  const TreatmentsUpdated({
    @required this.treatments,
  });

  final List<Treatment> treatments;

  @override
  List<Object> get props => [treatments];
}
