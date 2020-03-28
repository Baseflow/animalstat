part of 'recurring_treatments_bloc.dart';

class RecurringTreatmentsState extends Equatable {
  final bool isLoading;
  final DateTime selectedDate;
  final List<RecurringTreatment> treatments;

  RecurringTreatmentsState({
    this.isLoading,
    this.selectedDate,
    this.treatments,
  });

  String get selectedDateDisplayValue => selectedDate.toDisplayValue();
  @override
  List<Object> get props => [selectedDate, treatments];

  factory RecurringTreatmentsState.initial() {
    return RecurringTreatmentsState(
      isLoading: false,
      selectedDate: DateTime.now().toDate(),
      treatments: [],
    );
  }

  factory RecurringTreatmentsState.loading(DateTime selectedDate,) {
    return RecurringTreatmentsState(
      isLoading: true,
      selectedDate: selectedDate,
      treatments: [],
    );
  }

  RecurringTreatmentsState copyWith({
    bool isLoading,
    DateTime selectedDate,
    List<RecurringTreatment> treatments,
  }) {
    return RecurringTreatmentsState(
      isLoading: isLoading ?? this.isLoading,
      selectedDate: selectedDate ?? this.selectedDate,
      treatments: treatments ?? this.treatments,
    );
  }
}
