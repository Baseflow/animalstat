import 'package:livestock_repository/livestock_repository.dart';

class FirestoreTreatmentsConverter {
  static Treatments toEnum(String firestorePath){
    switch(firestorePath) {
      case 'treatments/Ampi':
        return Treatments.ampi;
      case 'treatments/Depo':
        return Treatments.depo;
      case 'treatments/Novem':
        return Treatments.novem;
      case 'treatments/Resflor':
        return Treatments.resflor;
      default:
        return Treatments.none;
    }
  }

  static String fromEnum(Treatments diagnosis)
  {
    switch(diagnosis) {
      case Treatments.ampi:
        return 'treatments/Ampi';
      case Treatments.depo:
        return 'treatments/Depo';
      case Treatments.novem:
        return 'treatments/Novem';
      case Treatments.resflor:
        return 'treatments/Resflor';
      default:
        return null;
    }
  }
}