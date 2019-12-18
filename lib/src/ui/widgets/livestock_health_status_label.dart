import 'package:flutter/material.dart';
import 'package:livestock/src/ui/widgets/livestock_segmented_button.dart';
import 'package:livestock_repository/livestock_repository.dart';
import 'package:livestock/src/utilities/enum_converters.dart';

class LivestockHealthStatusLabel extends StatelessWidget {
  final HealthStates healthStatus;
  final bool isSelected;

  const LivestockHealthStatusLabel({
    @required this.healthStatus,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    if (healthStatus == HealthStates.unknown) {
      return Container();
    }

    return LivestockSegmentedButton(
      borderColor: isSelected ? EnumConverters.toHealthStatusTextColor(healthStatus) : null,
      backgroundColor: EnumConverters.toHealthStatusBackgroundColor(healthStatus),
      text: EnumConverters.toHealthStatusDisplayValue(healthStatus),
      textColor: EnumConverters.toHealthStatusTextColor(healthStatus),
    );
  }
}
