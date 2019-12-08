import 'package:flutter/material.dart';
import 'package:livestock_repository/livestock_repository.dart';
import 'package:livestock/src/utilities/enum_converters.dart';

class LivestockHealthStatusLabel extends StatelessWidget {
  final HealthStates healthStatus;

  const LivestockHealthStatusLabel({this.healthStatus});

  @override
  Widget build(BuildContext context) {
    if (healthStatus == HealthStates.unknown) {
      return Container();
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(17.0)),
        color: EnumConverters.toHealthStatusBackgroundColor(healthStatus),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15.0,
          right: 15.0,
          top: 7.0,
          bottom: 7.0,
        ),
        child: Text(
          EnumConverters.toHealthStatusDisplayValue(healthStatus),
          style: TextStyle(
            color: EnumConverters.toHealthStatusTextColor(healthStatus),
            fontSize: 15.0,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
