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
  final List<RecurringTreatment> treatments;

  TreatmentsUpdated({@required this.treatments});

  @override
  List<Object> get props => [treatments];
}