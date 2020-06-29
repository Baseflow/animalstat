import 'package:flutter/material.dart';
import 'package:animalstat/src/ui/widgets/animalstat_health_status_label.dart';
import 'package:animalstat/src/ui/widgets/animalstat_toggle_button.dart';
import 'package:animalstat_repository/animalstat_repository.dart';

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
    return AnimalstatToggleButton(
      children: _healthStatusIndexMap.values
          .map((v) => AnimalstatHealthStatusLabel(
                healthStatus: v,
              ))
          .toList(),
      onPressed: (index) => onChanged(_healthStatusIndexMap[index]),
      selectedChildren: _healthStatusIndexMap.values
          .map((v) => AnimalstatHealthStatusLabel(
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
