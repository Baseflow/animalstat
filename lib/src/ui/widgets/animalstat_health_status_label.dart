import 'package:flutter/material.dart';
import 'package:animalstat/src/ui/widgets/animalstat_segmented_button.dart';
import 'package:animalstat_repository/animalstat_repository.dart';
import 'package:animalstat/src/utilities/enum_converters.dart';

class AnimalstatHealthStatusLabel extends StatelessWidget {
  final HealthStates healthStatus;
  final bool isSelected;

  const AnimalstatHealthStatusLabel({
    @required this.healthStatus,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    if (healthStatus == HealthStates.unknown) {
      return Container();
    }

    return AnimalstatSegmentedButton(
      borderColor: isSelected ? EnumConverters.toHealthStatusTextColor(healthStatus) : null,
      backgroundColor: EnumConverters.toHealthStatusBackgroundColor(healthStatus),
      text: EnumConverters.toHealthStatusDisplayValue(healthStatus),
      textColor: EnumConverters.toHealthStatusTextColor(healthStatus),
    );
  }
}
