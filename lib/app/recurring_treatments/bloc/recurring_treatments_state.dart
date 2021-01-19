part of 'recurring_treatments_bloc.dart';

class RecurringTreatmentsState extends Equatable {
  final bool isLoading;
  final DateTime selectedDate;
  final List<RecurringTreatmentListItem> openTreatments;
  final List<RecurringTreatmentListItem> appliedTreatments;
  final List<RecurringTreatmentListItem> cancelledTreatments;

  bool get notFound =>
      (openTreatments?.length ?? 0) == 0 &&
      (appliedTreatments?.length ?? 0) == 0 &&
      (cancelledTreatments?.length ?? 0) == 0;

  RecurringTreatmentsState({
    this.isLoading,
    this.selectedDate,
    this.openTreatments,
    this.appliedTreatments,
    this.cancelledTreatments,
  });

  String get selectedDateDisplayValue => selectedDate.toDisplayValue();

  @override
  List<Object> get props => [
        isLoading,
        selectedDate,
        openTreatments,
        appliedTreatments,
        cancelledTreatments,
      ];

  factory RecurringTreatmentsState.initial() {
    return RecurringTreatmentsState(
      isLoading: false,
      selectedDate: DateTime.now().toDate(),
      openTreatments: [],
      appliedTreatments: [],
      cancelledTreatments: [],
    );
  }

  factory RecurringTreatmentsState.loading(
    DateTime selectedDate,
  ) {
    return RecurringTreatmentsState(
      isLoading: true,
      selectedDate: selectedDate,
      openTreatments: [],
      appliedTreatments: [],
      cancelledTreatments: [],
    );
  }

  RecurringTreatmentsState copyWith({
    bool isLoading,
    DateTime selectedDate,
    List<RecurringTreatmentListItem> openTreatments,
    List<RecurringTreatmentListItem> appliedTreatments,
    List<RecurringTreatmentListItem> cancelledTreatments,
  }) {
    return RecurringTreatmentsState(
      isLoading: isLoading ?? this.isLoading,
      selectedDate: selectedDate ?? this.selectedDate,
      openTreatments: openTreatments ?? this.openTreatments,
      appliedTreatments: appliedTreatments ?? this.appliedTreatments,
      cancelledTreatments: cancelledTreatments ?? this.cancelledTreatments,
    );
  }
}
