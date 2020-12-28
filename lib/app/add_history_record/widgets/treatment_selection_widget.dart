import 'package:animalstat_repository/animalstat_repository.dart';
import 'package:flutter/material.dart';

import '../../../src/ui/widgets/animalstat_segmented_button.dart';
import '../../../src/ui/widgets/animalstat_toggle_button.dart';
import '../../../src/utilities/enum_converters.dart';

class TreatmentSelectionWidget extends StatelessWidget {
  TreatmentSelectionWidget({this.onChanged, this.selectedTreatment});

  final Map<int, Treatments> _treatmentIndexMap = <int, Treatments>{
    0: Treatments.ampi,
    1: Treatments.depo,
    2: Treatments.novem,
    3: Treatments.resflor,
  };

  final void Function(Treatments treatment) onChanged;
  final Treatments selectedTreatment;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return AnimalstatToggleButton(
      children: _treatmentIndexMap.values
          .map((v) => AnimalstatSegmentedButton(
                borderColor: const Color.fromRGBO(99, 99, 99, 1),
                backgroundColor: Colors.transparent,
                text: EnumConverters.toTreatmentDisplayValue(v),
                textColor: const Color.fromRGBO(99, 99, 99, 1),
              ))
          .toList(),
      onPressed: (index) => onChanged(_treatmentIndexMap[index]),
      selectedChildren: _treatmentIndexMap.values
          .map((v) => AnimalstatSegmentedButton(
                backgroundColor: _theme.buttonColor,
                text: EnumConverters.toTreatmentDisplayValue(v),
                textColor: Colors.white,
              ))
          .toList(),
      selectedIndex: _findKey(selectedTreatment),
    );
  }

  int _findKey(Treatments treatment) {
    return _treatmentIndexMap.keys.firstWhere(
        (k) => _treatmentIndexMap[k] == treatment,
        orElse: () => null);
  }
}
