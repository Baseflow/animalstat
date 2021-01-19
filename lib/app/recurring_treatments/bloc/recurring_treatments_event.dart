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
  final List<RecurringTreatmentListItem> openTreatments;
  final List<RecurringTreatmentListItem> appliedTreatments;
  final List<RecurringTreatmentListItem> cancelledTreatments;

  TreatmentsUpdated({
    @required this.openTreatments,
    @required this.appliedTreatments,
    @required this.cancelledTreatments,
  });

  @override
  List<Object> get props => [
        openTreatments,
        appliedTreatments,
        cancelledTreatments,
      ];
}

class UpdateTreatment extends RecurringTreatmentsEvent {
  final TreatmentStates treatmentStatus;
  final RecurringTreatmentCardState cardState;

  UpdateTreatment({@required this.treatmentStatus, @required this.cardState});

  @override
  List<Object> get props => [treatmentStatus, cardState];
}
