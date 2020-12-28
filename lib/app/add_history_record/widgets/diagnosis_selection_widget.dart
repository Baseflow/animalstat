import 'package:animalstat_repository/animalstat_repository.dart';
import 'package:flutter/material.dart';

import '../../../src/ui/widgets/animalstat_segmented_button.dart';
import '../../../src/ui/widgets/animalstat_toggle_button.dart';
import '../../../src/utilities/enum_converters.dart';

class DiagnosisSelectionWidget extends StatelessWidget {
  DiagnosisSelectionWidget({this.onChanged, this.selectedDiagnosis});

  final Map<int, Diagnoses> _diagnosisIndexMap = <int, Diagnoses>{
    0: Diagnoses.arthritis,
    1: Diagnoses.diarrhea,
    2: Diagnoses.lung,
    3: Diagnoses.orf,
  };

  final void Function(Diagnoses diagnosis) onChanged;
  final Diagnoses selectedDiagnosis;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return AnimalstatToggleButton(
      children: _diagnosisIndexMap.values
          .map((v) => AnimalstatSegmentedButton(
                borderColor: const Color.fromRGBO(99, 99, 99, 1),
                backgroundColor: Colors.transparent,
                text: EnumConverters.toDiagnosesDisplayValue(v),
                textColor: const Color.fromRGBO(99, 99, 99, 1),
              ))
          .toList(),
      onPressed: (index) => onChanged(_diagnosisIndexMap[index]),
      selectedChildren: _diagnosisIndexMap.values
          .map((v) => AnimalstatSegmentedButton(
                backgroundColor: _theme.buttonColor,
                text: EnumConverters.toDiagnosesDisplayValue(v),
                textColor: Colors.white,
              ))
          .toList(),
      selectedIndex: _findKey(selectedDiagnosis),
    );
  }

  int _findKey(Diagnoses diagnosis) {
    return _diagnosisIndexMap.keys.firstWhere(
        (k) => _diagnosisIndexMap[k] == diagnosis,
        orElse: () => null);
  }
}
