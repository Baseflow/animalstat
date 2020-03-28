import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:livestock_repository/livestock_repository.dart';

class AnimalHistoryCardState extends Equatable
{
  AnimalHistoryCardState({
    this.animalNumber,
    this.cage,
    this.diagnosis,
    this.healthStatus,
    this.seenOn,
    this.treatment,
  });

  final int animalNumber;
  final int cage;
  final Diagnoses diagnosis;
  final HealthStates healthStatus;
  final DateTime seenOn;
  final Treatments treatment;

  String get seenOnDisplayValue => '${DateFormat('dd-MM-yyyy').format(seenOn)}';
  String get cageDisplayValue => 'hok: $cage';
  
  AnimalHistoryCardState copyWith({
    int animalNumber, 
    int cage,
    Diagnoses diagnosis,
    HealthStates healthStatus,
    DateTime seenOn,
    Treatments treatment
  }) {
    return AnimalHistoryCardState(
      animalNumber: animalNumber ?? this.animalNumber,
      cage: cage ?? this.cage,
      diagnosis: diagnosis ?? this.diagnosis,
      healthStatus: healthStatus ?? this.healthStatus,
      seenOn: seenOn ?? this.seenOn,
      treatment: treatment ?? this.treatment,
    );
  }

  @override
  List<Object> get props => [
    animalNumber,
    cage,
    diagnosis,
    healthStatus,
    seenOn,
    treatment,
  ];
}