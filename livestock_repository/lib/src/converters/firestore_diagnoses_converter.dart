import 'package:livestock_repository/livestock_repository.dart';

class FirestoreDiagnosesConverter {
  static Diagnoses toEnum(int diagnosis){
    return diagnosis == null 
      ? Diagnoses.none
      : Diagnoses.values[diagnosis];
  }
}