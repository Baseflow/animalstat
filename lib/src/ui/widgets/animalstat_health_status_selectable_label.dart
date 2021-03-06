import 'package:animalstat_repository/animalstat_repository.dart';
import 'package:flutter/material.dart';

import '../../utilities/enum_converters.dart';
import 'animalstat_segmented_button.dart';

class AnimalstatHealthStatusSelectableLabel extends StatelessWidget {
  final HealthStates healthStatus;
  final bool isSelected;

  const AnimalstatHealthStatusSelectableLabel({
    @required this.healthStatus,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    if (healthStatus == HealthStates.unknown) {
      return Container();
    }

    return AnimalstatSegmentedButton(
      borderColor: isSelected
          ? EnumConverters.toHealthStatusTextColor(healthStatus)
          : EnumConverters.toHealthStatusBackgroundColor(healthStatus),
      backgroundColor: isSelected
          ? EnumConverters.toHealthStatusTextColor(healthStatus)
          : _theme.dialogBackgroundColor,
      textColor: isSelected
          ? _theme.dialogBackgroundColor
          : EnumConverters.toHealthStatusTextColor(healthStatus),
      text: EnumConverters.toHealthStatusDisplayValue(healthStatus),
    );
  }
}
