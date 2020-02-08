import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:livestock/app/add_animal_detail/widgets/add_animal_detail_header.dart';
import 'package:livestock/app/add_animal_detail/widgets/diagnosis_selection_widget.dart';
import 'package:livestock/app/add_animal_detail/widgets/health_status_selection_widget.dart';
import 'package:livestock/app/add_animal_detail/widgets/treatment_selection_widget.dart';
import 'package:livestock/src/ui/widgets/livestock_primary_button.dart';
import 'package:livestock_repository/livestock_repository.dart';

import 'bloc/bloc.dart';

class AddAnimalDetailDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddAnimalDetailDialogState();
}

class _AddAnimalDetailDialogState extends State<AddAnimalDetailDialog> {
  Diagnoses selectedDiagnosis;
  HealthStates selectedHealthStatus;
  Treatments selectedTreatment;

  @override
  void initState() {
    selectedDiagnosis = null;
    selectedHealthStatus = null;
    selectedTreatment = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20,
        ),
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: BlocListener<AddAnimalDetailBloc, AddAnimalDetailState>(
                listener: (context, state) {
                  if (state is HistoryRecordSaved) {
                    Navigator.of(context).pop();
                  }
                },
                child: BlocBuilder<AddAnimalDetailBloc, AddAnimalDetailState>(
                  builder: (context, state) {
                    if (state is HistoryRecordSaved) {
                      return Container();
                    }

                    if (state is AddAnimalDetailState) {
                      return Column(
                        children: <Widget>[
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  AddAnimalDetailHeader(
                                    onClose: () => Navigator.of(context).pop(),
                                  ),
                                  ..._buildDateRow(
                                      state.registrationDateDisplayValue),
                                  ..._buildHealthStatusSelectionRow(state),
                                  ..._buildDiagnosisSelectionRow(state),
                                  ..._buildTreatmentSelectionRow(state),
                                ],
                              ),
                            ),
                          ),
                          _buildBottomBar(state),
                        ],
                      );
                    }

                    return Container();
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar(AddAnimalDetailState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Divider(),
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: LivestockPrimaryButton(
            text: 'Opslaan',
            onPressed: () => BlocProvider.of<AddAnimalDetailBloc>(context).add(
              SaveAnimalHistoryRecord(
                stateToSave: state,
              ),
            ),
            icon: Icon(
              FontAwesomeIcons.plus,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildDateRow(String dateToDisplay) {
    return <Widget>[
      Divider(),
      Padding(
        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Datum',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
            Text(
              dateToDisplay,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> _buildDiagnosisSelectionRow(
      AddAnimalDetailState animalDetailState) {
    if (!animalDetailState.allowDiagnosisSelection) {
      return <Widget>[];
    }

    return <Widget>[
      Divider(),
      Padding(
        padding: const EdgeInsets.only(top: 15.0, bottom: 8.0),
        child: Text(
          'Diagnose',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: DiagnosisSelectionWidget(
          onChanged: (diagnosis) =>
              BlocProvider.of<AddAnimalDetailBloc>(context).add(
            UpdateDiagnosis(
              diagnosis: diagnosis,
              previousState: animalDetailState,
            ),
          ),
          selectedDiagnosis: animalDetailState.diagnosis,
        ),
      ),
    ];
  }

  List<Widget> _buildHealthStatusSelectionRow(
      AddAnimalDetailState animalDetailState) {
    return <Widget>[
      Divider(),
      Padding(
        padding: const EdgeInsets.only(top: 15.0, bottom: 8.0),
        child: Text(
          'Gezondheidsstatus',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: HealthStatusSelectionWidget(
          onChanged: (healthStatus) =>
              BlocProvider.of<AddAnimalDetailBloc>(context).add(
            UpdateHealthStatus(
              healthStatus: healthStatus,
              previousState: animalDetailState,
            ),
          ),
          selectedHealthStatus: animalDetailState.healthStatus,
        ),
      ),
    ];
  }

  List<Widget> _buildTreatmentSelectionRow(
      AddAnimalDetailState animalDetailState) {
    if (!animalDetailState.allowTreatmentSelection) {
      return <Widget>[];
    }

    return <Widget>[
      Divider(),
      Padding(
        padding: const EdgeInsets.only(top: 15.0, bottom: 8.0),
        child: Text(
          'Behandeling',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: TreatmentSelectionWidget(
          onChanged: (treatment) =>
              BlocProvider.of<AddAnimalDetailBloc>(context).add(
            UpdateTreatment(
              treatment: treatment,
              previousState: animalDetailState,
            ),
          ),
          selectedTreatment: animalDetailState.treatment,
        ),
      ),
    ];
  }
}
