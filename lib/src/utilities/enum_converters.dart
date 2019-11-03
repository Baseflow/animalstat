import 'package:animal_repository/animal_repository.dart';
import 'package:flutter/material.dart';

class EnumConverters {
    static String toDisplayValue(AnimalHealthStates healthStatus) {
      switch(healthStatus)
      {
        case AnimalHealthStates.healthy:
          return 'Gezond';
        case AnimalHealthStates.ill:
          return 'Ziek';
        case AnimalHealthStates.suspicious:
          return 'Verdacht';
        case AnimalHealthStates.deceased:
          return 'Overleden';
        case AnimalHealthStates.unknown:
        default:
          return null;
      }
    }

    static Color toBackgroundColor(AnimalHealthStates healthStatus) {
      switch(healthStatus)
      {
        case AnimalHealthStates.healthy:
          return Color.fromRGBO(153, 241, 166, 1);
        case AnimalHealthStates.ill:
          return Color.fromRGBO(169, 233, 255, 1);
        case AnimalHealthStates.suspicious:
          return Color.fromRGBO(255, 239, 200, 1);
        case AnimalHealthStates.deceased:
          return Color.fromRGBO(194, 147, 147, 1);
        case AnimalHealthStates.unknown:
        default:
          return null;
      }
    }

    static Color toTextColor(AnimalHealthStates healthStatus) {
      switch(healthStatus)
      {
        case AnimalHealthStates.healthy:
          return Color.fromRGBO(3, 105, 38, 1);
        case AnimalHealthStates.ill:
          return Color.fromRGBO(21, 98, 124, 1);
        case AnimalHealthStates.suspicious:
          return Color.fromRGBO(125, 89, 1, 1);
        case AnimalHealthStates.deceased:
          return Color.fromRGBO(54, 12, 8, 1);
        case AnimalHealthStates.unknown:
        default:
          return null;
      }
    }
}