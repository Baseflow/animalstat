import 'package:animal_repository/animal_repository.dart';

class FirestoreDiagnosesConverter {
  static Diagnoses toEnum(String firestorePath){
    switch(firestorePath) {
      case 'diagnoses/Diarree':
        return Diagnoses.diarrhea;
      case 'diagnoses/Gewrichtsontsteking':
        return Diagnoses.arthritis;
      case 'diagnoses/Long':
        return Diagnoses.lung;
      case 'diagnoses/Orf':
        return Diagnoses.orf;
      default:
        return Diagnoses.none;
    }
  }

  static String fromEnum(Diagnoses diagnosis)
  {
    switch(diagnosis) {
      case Diagnoses.arthritis:
        return 'diagnoses/Gewrichtsontsteking';
      case Diagnoses.diarrhea:
        return 'diagnoses/Diarree';
      case Diagnoses.lung:
        return 'diagnoses/Long';
      case Diagnoses.orf:
        return 'diagnoses/Orf';
      default:
        return null;
    }
  }
}