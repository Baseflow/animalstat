import '../../animalstat_repository.dart';

extension MapExtensions on Map<String, dynamic> {
  /// Converts a map into a [Diagnosis]] instance.
  ///
  /// Returns `null` if the map doesn't contain the correct fields.
  Diagnosis toDiagnosis() {
    final diagnosisMap = this['diagnosis'];

    if (diagnosisMap == null) {
      return null;
    }

    final id = diagnosisMap['id'];
    final name = diagnosisMap['name'];

    if (id == null || name == null) {
      return null;
    }

    return Diagnosis(
      id,
      name,
    );
  }

  /// Converts a map into a [Treatment] instance.
  ///
  /// Returns `null` if the map doesn't contain the correct fields.
  Treatment toTreatment() {
    final treatmentMap = this['treatment'];

    if (treatmentMap == null) {
      return null;
    }

    final id = treatmentMap['id'];
    final diagnosisId = treatmentMap['diagnosis_id'];
    final name = treatmentMap['name'];

    if (id == null || name == null) {
      return null;
    }

    return Treatment(
      id,
      diagnosisId,
      name,
    );
  }
}
