part of 'recurring_treatments_bloc.dart';

abstract class RecurringTreatmentsEvent extends Equatable {
  const RecurringTreatmentsEvent();
}

class LoadTreatments extends RecurringTreatmentsEvent {
  final DateTime selectedDate;

  LoadTreatments({@required this.selectedDate});

  @override
  List<Object> get props => [selectedDate];
}

class SelectedDateChanged extends RecurringTreatmentsEvent {
  final DateTime selectedDate;

  SelectedDateChanged({@required this.selectedDate});

  @override
  List<Object> get props => [selectedDate];
}

class TreatmentsUpdated extends RecurringTreatmentsEvent {
  final List<RecurringTreatmentCardState> treatments;

  TreatmentsUpdated({@required this.treatments});

  @override
  List<Object> get props => [treatments];
}

class UpdateTreatment extends RecurringTreatmentsEvent {
  final TreatmentStates treatmentStatus;
  final RecurringTreatmentCardState cardState;

  UpdateTreatment({@required this.treatmentStatus, @required this.cardState});

  @override
  List<Object> get props => [treatmentStatus, cardState];
}