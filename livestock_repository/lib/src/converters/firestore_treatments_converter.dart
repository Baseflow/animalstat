import 'package:livestock_repository/livestock_repository.dart';

class FirestoreTreatmentsConverter {
  static Treatments toEnum(int treatment){
    return treatment == null 
      ? Treatments.none
      : Treatments.values[treatment];
  }
}