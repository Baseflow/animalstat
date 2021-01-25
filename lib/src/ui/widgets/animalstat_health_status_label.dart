import 'package:animalstat_repository/animalstat_repository.dart';
import 'package:flutter/material.dart';

import '../../utilities/enum_converters.dart';
import 'animalstat_segmented_button.dart';

class AnimalstatHealthStatusLabel extends StatelessWidget {
  final HealthStates healthStatus;

  const AnimalstatHealthStatusLabel({
    @required this.healthStatus,
  });

  @override
  Widget build(BuildContext context) {
    if (healthStatus == HealthStates.unknown) {
      return Container();
    }

    return AnimalstatSegmentedButton(
      backgroundColor:
          EnumConverters.toHealthStatusBackgroundColor(healthStatus),
      text: EnumConverters.toHealthStatusDisplayValue(healthStatus),
      textColor: EnumConverters.toHealthStatusTextColor(healthStatus),
    );
  }
}
