import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:livestock/app/add_animal_detail/bloc/bloc.dart';
import 'package:livestock_repository/livestock_repository.dart';
import 'package:meta/meta.dart';

class AddAnimalDetailState extends Equatable {
  AddAnimalDetailState({
    @required this.animalNumber,
    @required this.seenOn,
    this.diagnosis,
    this.healthStatus,
    this.treatment,
  });

  final int animalNumber;
  final Diagnoses diagnosis;
  final HealthStates healthStatus;
  final DateTime seenOn;
  final Treatments treatment;

  bool get allowDiagnosisSelection => AddAnimalDetailBloc.allowDiagnosisSelection(healthStatus);
  bool get allowTreatmentSelection => AddAnimalDetailBloc.allowTreatmentSelection(healthStatus, diagnosis);

  String get registrationDateDisplayValue => DateFormat('dd-MM-yyyy').format(seenOn);

  factory AddAnimalDetailState.initial(int animalNumber) {
    return AddAnimalDetailState(
      animalNumber: animalNumber,
      seenOn: DateTime.now(),
      diagnosis: Diagnoses.none,
      healthStatus: HealthStates.unknown,
      treatment: Treatments.none
    );
  }

  AddAnimalDetailState copyWith({
    int animalNumber,
    Diagnoses diagnosis,
    HealthStates healthStatus,
    DateTime registrationDate,
    Treatments treatment,
  }) {
    return AddAnimalDetailState(
      animalNumber: animalNumber ?? this.animalNumber,
      diagnosis: diagnosis ?? this.diagnosis,
      healthStatus: healthStatus ?? this.healthStatus,
      seenOn: registrationDate ?? this.seenOn,
      treatment: treatment ?? this.treatment,
    );
  }

  AnimalHistoryRecord toModel() {
    return AnimalHistoryRecord(
      diagnosis,
      healthStatus,
      seenOn,
      treatment,
    );
  }

  @override
  List<Object> get props =>
      [diagnosis, healthStatus, seenOn, treatment];
}

class HistoryRecordSaved extends AddAnimalDetailState {
  @override
  List<Object> get props => [];
}