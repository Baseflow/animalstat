import 'package:flutter/material.dart';
import 'package:livestock/src/ui/widgets/livestock_segmented_button.dart';
import 'package:livestock/src/ui/widgets/livestock_toggle_button.dart';
import 'package:livestock/src/utilities/enum_converters.dart';
import 'package:livestock_repository/livestock_repository.dart';

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
    return LivestockToggleButton(
      children: _treatmentIndexMap.values
          .map((v) => LivestockSegmentedButton(
                borderColor: Color.fromRGBO(99, 99, 99, 1),
                backgroundColor: Colors.transparent,
                text: EnumConverters.toTreatmentDisplayValue(v),
                textColor: Color.fromRGBO(99, 99, 99, 1),
              ))
          .toList(),
      onPressed: (index) => onChanged(_treatmentIndexMap[index]),
      selectedChildren: _treatmentIndexMap.values
          .map((v) => LivestockSegmentedButton(
                backgroundColor: Color.fromRGBO(99, 99, 99, 1),
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
