import '../models/diagnoses.dart';

class FirestoreDiagnosesConverter {
  static Diagnoses toEnum(int diagnosis){
    return diagnosis == null 
      ? Diagnoses.none
      : Diagnoses.values[diagnosis];
  }
}