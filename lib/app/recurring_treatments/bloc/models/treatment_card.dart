import 'package:animalstat_repository/animalstat_repository.dart';
import 'package:equatable/equatable.dart';

class TreatmentCard extends Equatable {
  TreatmentCard({
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
  final String diagnosis;
  final HealthStates healthStatus;
  final String treatment;

  String get cageDisplayValue => 'hok: $cage';

  TreatmentCard copyWith(
      {int animalNumber,
      int cage,
      String diagnosis,
      HealthStates healthStatus,
      String treatment}) {
    return TreatmentCard(
      recurringTreatmentId: recurringTreatmentId,
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
