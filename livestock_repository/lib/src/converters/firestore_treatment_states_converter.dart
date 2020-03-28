import 'package:livestock_repository/livestock_repository.dart';

class FirestoreTreatmentStatesConverter {
  static TreatmentStates toEnum(int treatmentStatus){
    return treatmentStatus == null 
      ? TreatmentStates.unknown
      : TreatmentStates.values[treatmentStatus];
  }
}