import 'package:animal_repository/animal_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
        return Color.fromRGBO(153, 241, 166, 1);
      case HealthStates.ill:
        return Color.fromRGBO(169, 233, 255, 1);
      case HealthStates.suspicious:
        return Color.fromRGBO(255, 239, 200, 1);
      case HealthStates.deceased:
        return Color.fromRGBO(194, 147, 147, 1);
      case HealthStates.unknown:
      default:
        return null;
    }
  }

  static Color toHealthStatusTextColor(HealthStates healthStatus) {
    switch (healthStatus) {
      case HealthStates.healthy:
        return Color.fromRGBO(3, 105, 38, 1);
      case HealthStates.ill:
        return Color.fromRGBO(21, 98, 124, 1);
      case HealthStates.suspicious:
        return Color.fromRGBO(125, 89, 1, 1);
      case HealthStates.deceased:
        return Color.fromRGBO(54, 12, 8, 1);
      case HealthStates.unknown:
      default:
        return null;
    }
  }
}
