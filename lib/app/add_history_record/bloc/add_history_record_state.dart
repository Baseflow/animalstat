import 'package:animalstat_repository/animalstat_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import '../../../src/extensions/date_time_extensions.dart';
import 'bloc.dart';

class AddHistoryRecordState extends Equatable {
  AddHistoryRecordState({
    @required this.animalNumber,
    @required this.user,
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
  final User user;
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
        user,
        seenOn,
        treatment,
        treatmentEndDate,
      ];

  factory AddHistoryRecordState.initial(int animalNumber, User user) {
    return AddHistoryRecordState(
      animalNumber: animalNumber,
      diagnosis: Diagnoses.none,
      healthStatus: HealthStates.unknown,
      isSaved: false,
      seenOn: DateTime.now(),
      treatment: Treatments.none,
      treatmentEndDate: null,
      user: user,
    );
  }

  AddHistoryRecordState copyWith({
    int animalNumber,
    int cage,
    Diagnoses diagnosis,
    HealthStates healthStatus,
    bool isSaved,
    User user,
    DateTime seenOn,
    Treatments treatment,
    DateTime treatmentEndDate,
  }) {
    return AddHistoryRecordState(
      animalNumber: animalNumber ?? this.animalNumber,
      cage: cage ?? this.cage,
      diagnosis: diagnosis ?? this.diagnosis,
      healthStatus: healthStatus ?? this.healthStatus,
      isSaved: isSaved ?? this.isSaved,
      user: user ?? this.user,
      seenOn: seenOn ?? this.seenOn,
      treatment: treatment ?? this.treatment,
      treatmentEndDate: treatmentEndDate ?? this.treatmentEndDate,
    );
  }

  AnimalHistoryRecord toModel() {
    final userInfo = UserInfo(
      user.id,
      user.email,
    );

    return AnimalHistoryRecord(
      cage,
      diagnosis,
      healthStatus,
      userInfo,
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
