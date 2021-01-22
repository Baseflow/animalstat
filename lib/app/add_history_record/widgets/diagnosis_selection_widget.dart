import 'package:animalstat/app/add_history_record/bloc/diagnoses_bloc.dart';
import 'package:animalstat_repository/animalstat_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../src/ui/widgets/animalstat_segmented_button.dart';
import '../../../src/ui/widgets/animalstat_toggle_button.dart';

class DiagnosisSelectionWidget extends StatelessWidget {
  DiagnosisSelectionWidget({this.onChanged, this.selectedDiagnosis});

  final void Function(Diagnosis diagnosis) onChanged;
  final Diagnosis selectedDiagnosis;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return BlocBuilder<DiagnosesBloc, DiagnosesState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.isEmpty) {
          return Container();
        }

        return AnimalstatToggleButton(
          children: state.diagnoses
              .map((diagnosis) => AnimalstatSegmentedButton(
                    borderColor: const Color.fromRGBO(99, 99, 99, 1),
                    backgroundColor: Colors.transparent,
                    text: diagnosis.name,
                    textColor: const Color.fromRGBO(99, 99, 99, 1),
                  ))
              .toList(),
          onPressed: (index) => onChanged(state.diagnoses[index]),
          selectedChildren: state.diagnoses
              .map((diagnosis) => AnimalstatSegmentedButton(
                    backgroundColor: _theme.buttonColor,
                    text: diagnosis.name,
                    textColor: Colors.white,
                  ))
              .toList(),
          selectedIndex: state.diagnoses.indexOf(selectedDiagnosis),
        );
      },
    );
  }
}
