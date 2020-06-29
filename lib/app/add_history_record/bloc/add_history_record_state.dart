import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:animalstat/app/add_history_record/bloc/bloc.dart';
import 'package:animalstat_repository/animalstat_repository.dart';
import 'package:meta/meta.dart';
import '../../../src/extensions/date_time_extensions.dart';

class AddHistoryRecordState extends Equatable {
  AddHistoryRecordState({
    @required this.animalNumber,
    @required this.seenOn,
    @required this.isSaved,
    this.cage,
    this.diagnosis,
    this.healthStatus,
    this.treatment,
    this.treatmentEndDate,
  });

  final int animalNumber;
  final int cage;
  final Diagnoses diagnosis;
  final HealthStates healthStatus;
  final bool isSaved;
  final DateTime seenOn;
  final Treatments treatment;
  final DateTime treatmentEndDate;

  bool get allowDiagnosisSelection =>
      AddHistoryRecordBloc.allowDiagnosisSelection(healthStatus);
  bool get allowTreatmentSelection =>
      AddHistoryRecordBloc.allowTreatmentSelection(healthStatus, diagnosis);
  bool get canSave => AddHistoryRecordBloc.canSaveState(this);
  String get cageDisplayValue => cage?.toString() ?? '';
  String get registrationDateDisplayValue =>
      DateFormat('dd-MM-yyyy').format(seenOn);
  String get treatmentEndDateDisplayValue =>
      _buildTreatmentEndDateDisplayValue();

  @override
  List<Object> get props => [
        animalNumber,
        cage,
        diagnosis,
        healthStatus,
        isSaved,
        seenOn,
        treatment,
        treatmentEndDate,
      ];

  factory AddHistoryRecordState.initial(int animalNumber) {
    return AddHistoryRecordState(
      animalNumber: animalNumber,
      diagnosis: Diagnoses.none,
      healthStatus: HealthStates.unknown,
      isSaved: false,
      seenOn: DateTime.now(),
      treatment: Treatments.none,
      treatmentEndDate: null,
    );
  }

  AddHistoryRecordState copyWith({
    int animalNumber,
    int cage,
    Diagnoses diagnosis,
    HealthStates healthStatus,
    bool isSaved,
    DateTime registrationDate,
    Treatments treatment,
    DateTime treatmentEndDate,
  }) {
    return AddHistoryRecordState(
      animalNumber: animalNumber ?? this.animalNumber,
      cage: cage ?? this.cage,
      diagnosis: diagnosis ?? this.diagnosis,
      healthStatus: healthStatus ?? this.healthStatus,
      isSaved: isSaved ?? this.isSaved,
      seenOn: registrationDate ?? this.seenOn,
      treatment: treatment ?? this.treatment,
      treatmentEndDate: treatmentEndDate ?? this.treatmentEndDate,
    );
  }

  AnimalHistoryRecord toModel() {
    return AnimalHistoryRecord(
      cage,
      diagnosis,
      healthStatus,
      seenOn,
      treatment,
      treatmentEndDate,
    );
  }

  String _buildTreatmentEndDateDisplayValue() {
    if (treatmentEndDate == null) {
      return 'Geen herhaling';
    }

    return treatmentEndDate.toDisplayValue();
  }
}
