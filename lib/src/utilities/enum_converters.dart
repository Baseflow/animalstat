import 'package:animalstat_repository/animalstat_repository.dart';
import 'package:flutter/material.dart';

class EnumConverters {
  static String toDiagnosesDisplayValue(Diagnoses diagnoses) {
    switch (diagnoses) {
      case Diagnoses.arthritis:
        return 'Gewrichtsontsteking';
      case Diagnoses.diarrhea:
        return 'Diarree';
      case Diagnoses.lung:
        return 'Long';
      case Diagnoses.orf:
        return 'Orf';
      case Diagnoses.none:
      default:
        return null;
    }
  }

  static String toHealthStatusDisplayValue(HealthStates healthStatus) {
    switch (healthStatus) {
      case HealthStates.healthy:
        return 'Gezond';
      case HealthStates.ill:
        return 'Ziek';
      case HealthStates.suspicious:
        return 'Verdacht';
      case HealthStates.deceased:
        return 'Overleden';
      case HealthStates.unknown:
      default:
        return null;
    }
  }

  static String toTreatmentDisplayValue(Treatments treatment) {
    switch (treatment) {
      case Treatments.ampi:
        return 'Ampi';
      case Treatments.depo:
        return 'Depo';
      case Treatments.novem:
        return 'Novem';
      case Treatments.resflor:
        return 'Restflor';
      default:
        return null;
    }
  }

  static Color toHealthStatusBackgroundColor(HealthStates healthStatus) {
    switch (healthStatus) {
      case HealthStates.healthy:
        return const Color.fromRGBO(165, 214, 167, 1);
      case HealthStates.ill:
        return const Color.fromRGBO(179, 229, 252, 1);
      case HealthStates.suspicious:
        return const Color.fromRGBO(255, 204, 188, 1);
      case HealthStates.deceased:
        return const Color.fromRGBO(225, 190, 231, 1);
      case HealthStates.unknown:
      default:
        return null;
    }
  }

  static Color toHealthStatusTextColor(HealthStates healthStatus) {
    switch (healthStatus) {
      case HealthStates.healthy:
        return const Color.fromRGBO(27, 94, 32, 1);
      case HealthStates.ill:
        return const Color.fromRGBO(1, 87, 155, 1);
      case HealthStates.suspicious:
        return const Color.fromRGBO(191, 54, 12, 1);
      case HealthStates.deceased:
        return const Color.fromRGBO(106, 27, 154, 1);
      case HealthStates.unknown:
      default:
        return null;
    }
  }
}
