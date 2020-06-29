import '../models/treatment_states.dart';

class FirestoreTreatmentStatesConverter {
  static TreatmentStates toEnum(int treatmentStatus){
    return treatmentStatus == null 
      ? TreatmentStates.unknown
      : TreatmentStates.values[treatmentStatus];
  }
}