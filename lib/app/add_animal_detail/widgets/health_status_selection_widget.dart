import 'package:flutter/material.dart';
import 'package:livestock/src/ui/widgets/livestock_health_status_label.dart';
import 'package:livestock/src/ui/widgets/livestock_toggle_button.dart';
import 'package:livestock_repository/livestock_repository.dart';

class HealthStatusSelectionWidget extends StatelessWidget {
  HealthStatusSelectionWidget({this.onChanged, this.selectedHealthStatus});

  final Map<int, HealthStates> _healthStatusIndexMap = <int, HealthStates>{
    0: HealthStates.healthy,
    1: HealthStates.suspicious,
    2: HealthStates.ill,
    3: HealthStates.deceased,
  };

  final void Function(HealthStates healthStatus) onChanged;
  final HealthStates selectedHealthStatus;

  @override
  Widget build(BuildContext context) {
    return LivestockToggleButton(
      children: _healthStatusIndexMap.values
          .map((v) => LivestockHealthStatusLabel(
                healthStatus: v,
              ))
          .toList(),
      onPressed: (index) => onChanged(_healthStatusIndexMap[index]),
      selectedChildren: _healthStatusIndexMap.values
          .map((v) => LivestockHealthStatusLabel(
                healthStatus: v,
                isSelected: true,
              ))
          .toList(),
      selectedIndex: _findKey(selectedHealthStatus),
    );
  }

  int _findKey(HealthStates healthStatus) {
    return _healthStatusIndexMap.keys.firstWhere(
        (k) => _healthStatusIndexMap[k] == healthStatus,
        orElse: () => null);
  }
}
