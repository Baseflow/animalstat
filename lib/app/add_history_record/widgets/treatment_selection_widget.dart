import 'package:animalstat/app/add_history_record/bloc/treatments_bloc.dart';
import 'package:animalstat_repository/animalstat_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../src/ui/widgets/animalstat_segmented_button.dart';
import '../../../src/ui/widgets/animalstat_toggle_button.dart';

class TreatmentSelectionWidget extends StatelessWidget {
  TreatmentSelectionWidget({this.onChanged, this.selectedTreatment});

  final void Function(Treatment treatment) onChanged;
  final Treatment selectedTreatment;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return BlocBuilder<TreatmentsBloc, TreatmentsState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.isEmpty) {
          return Container();
        }

        return AnimalstatToggleButton(
          children: state.treatments
              .map((treatment) => AnimalstatSegmentedButton(
                    borderColor: const Color.fromRGBO(99, 99, 99, 1),
                    backgroundColor: Colors.transparent,
                    text: treatment.name,
                    textColor: const Color.fromRGBO(99, 99, 99, 1),
                  ))
              .toList(),
          onPressed: (index) => onChanged(state.treatments[index]),
          selectedChildren: state.treatments
              .map((diagnosis) => AnimalstatSegmentedButton(
                    backgroundColor: _theme.buttonColor,
                    text: diagnosis.name,
                    textColor: Colors.white,
                  ))
              .toList(),
          selectedIndex: state.treatments.indexOf(selectedTreatment),
        );
      },
    );
  }
}
