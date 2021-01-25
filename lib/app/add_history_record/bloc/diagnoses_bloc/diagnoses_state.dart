part of 'diagnoses_bloc.dart';

@immutable
class DiagnosesState extends Equatable {
  const DiagnosesState({
    @required this.diagnoses,
    @required this.isLoading,
  });

  final List<Diagnosis> diagnoses;
  final bool isLoading;

  bool get isEmpty => diagnoses == null || diagnoses.isEmpty;

  @override
  List<Object> get props => [
        diagnoses,
        isLoading,
      ];

  @override
  bool get stringify => true;

  factory DiagnosesState.initial() {
    return const DiagnosesState(
      diagnoses: null,
      isLoading: false,
    );
  }

  factory DiagnosesState.loading() {
    return const DiagnosesState(
      diagnoses: null,
      isLoading: true,
    );
  }

  DiagnosesState copyWith({
    List<Diagnosis> diagnoses,
    bool isLoading,
  }) {
    return DiagnosesState(
      diagnoses: diagnoses ?? this.diagnoses,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
