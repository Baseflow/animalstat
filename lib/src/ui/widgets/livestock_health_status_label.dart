import 'package:flutter/material.dart';
import 'package:animal_repository/animal_repository.dart';
import 'package:livestock/src/utilities/enum_converters.dart';

import '../theming.dart';

class LivestockHealthStatusLabel extends StatelessWidget {
  final AnimalHealthStates healthStatus;

  const LivestockHealthStatusLabel({this.healthStatus});

  @override
  Widget build(BuildContext context) {
    if (healthStatus == AnimalHealthStates.unknown) {
      return Container();
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(17.0)),
        color: EnumConverters.toBackgroundColor(healthStatus),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15.0,
          right: 15.0,
          top: 7.0,
          bottom: 7.0,
        ),
        child: Text(
          EnumConverters.toDisplayValue(healthStatus),
          style: TextStyle(
            color: EnumConverters.toTextColor(healthStatus),
            fontSize: 16.0,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
