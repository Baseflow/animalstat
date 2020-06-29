import '../models/treatments.dart';

class FirestoreTreatmentsConverter {
  static Treatments toEnum(int treatment){
    return treatment == null 
      ? Treatments.none
      : Treatments.values[treatment];
  }
}