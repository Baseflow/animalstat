part of 'treatments_bloc.dart';

@immutable
class TreatmentsState extends Equatable {
  const TreatmentsState({
    @required this.treatments,
    @required this.isLoading,
  });

  final List<Treatment> treatments;
  final bool isLoading;

  bool get isEmpty => treatments == null || treatments.isEmpty;

  @override
  List<Object> get props => [
        treatments,
        isLoading,
      ];

  @override
  bool get stringify => true;

  factory TreatmentsState.initial() {
    return const TreatmentsState(
      treatments: null,
      isLoading: false,
    );
  }

  factory TreatmentsState.loading() {
    return const TreatmentsState(
      treatments: null,
      isLoading: true,
    );
  }

  TreatmentsState copyWith({
    List<Treatment> treatments,
    bool isLoading,
  }) {
    return TreatmentsState(
      treatments: treatments ?? this.treatments,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
