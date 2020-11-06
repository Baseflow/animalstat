import '../../animalstat_repository.dart';

class RecurringTreatment {
  final String id;
  final DateTime administrationDate;
  final int animalNumber;
  final int cageNumber;
  final Diagnoses diagnosis;
  final HealthStates healthStatus;
  final Treatments treatment;
  final TreatmentStates treatmentStatus;

  RecurringTreatment({
    this.id,
    this.administrationDate,
    this.animalNumber,
    this.cageNumber,
    this.diagnosis,
    this.healthStatus,
    this.treatment,
    this.treatmentStatus,
  });

  @override
  int get hashCode =>
      id.hashCode ^
      administrationDate.hashCode ^
      animalNumber.hashCode ^
      cageNumber.hashCode ^
      diagnosis.hashCode ^
      healthStatus.hashCode ^
      treatment.hashCode ^
      treatmentStatus.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecurringTreatment &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          administrationDate == other.administrationDate &&
          animalNumber == other.animalNumber &&
          cageNumber == other.cageNumber &&
          diagnosis == other.diagnosis &&
          healthStatus == other.healthStatus &&
          treatment == other.treatment &&
          treatmentStatus == other.treatmentStatus;

  @override
  String toString() {
    return 'RecurringTreatment{id: $id, administrationDate: $administrationDate, animalNumber: $animalNumber, cageNumber: $cageNumber, diagnosis: $diagnosis, healthStatus: $healthStatus, treatment: $treatment, treatmentStatus: $treatmentStatus}';
  }
}
