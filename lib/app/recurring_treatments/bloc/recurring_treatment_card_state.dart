part of 'recurring_treatments_bloc.dart';

class RecurringTreatmentCardState extends Equatable
{
  RecurringTreatmentCardState({
    this.recurringTreatmentId,
    this.animalNumber,
    this.cage,
    this.diagnosis,
    this.healthStatus,
    this.treatment,
  });

  final String recurringTreatmentId;
  final int animalNumber;
  final int cage;
  final Diagnoses diagnosis;
  final HealthStates healthStatus;
  final Treatments treatment;

  String get cageDisplayValue => 'hok: $cage';
  
  RecurringTreatmentCardState copyWith({
    int animalNumber, 
    int cage,
    Diagnoses diagnosis,
    HealthStates healthStatus,
    Treatments treatment
  }) {
    return RecurringTreatmentCardState(
      recurringTreatmentId: this.recurringTreatmentId,
      animalNumber: animalNumber ?? this.animalNumber,
      cage: cage ?? this.cage,
      diagnosis: diagnosis ?? this.diagnosis,
      healthStatus: healthStatus ?? this.healthStatus,
      treatment: treatment ?? this.treatment,
    );
  }

  @override
  List<Object> get props => [
    recurringTreatmentId,
    animalNumber,
    cage,
    diagnosis,
    healthStatus,
    treatment,
  ];
}