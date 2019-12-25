import 'package:equatable/equatable.dart';
import 'package:livestock_repository/livestock_repository.dart';

class AnimalHistoryCardState extends Equatable
{
  AnimalHistoryCardState({
    this.animalNumber,
    this.diagnosis,
    this.healthStatus,
    this.seenOn,
    this.treatment,
  });

  final int animalNumber;
  final Diagnoses diagnosis;
  final HealthStates healthStatus;
  final String seenOn;
  final Treatments treatment;
  
  AnimalHistoryCardState copyWith({
    int animalNumber, 
    Diagnoses diagnosis,
    HealthStates healthStatus,
    String seenOn,
    Treatments treatment
  }) {
    return AnimalHistoryCardState(
      animalNumber: animalNumber ?? this.animalNumber,
      diagnosis: diagnosis ?? this.diagnosis,
      healthStatus: healthStatus ?? this.healthStatus,
      seenOn: seenOn ?? this.seenOn,
      treatment: treatment ?? this.treatment,
    );
  }

  @override
  List<Object> get props => [
    animalNumber,
    diagnosis,
    healthStatus,
    seenOn,
    treatment,
  ];
}