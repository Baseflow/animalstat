import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:livestock/app/add_animal_detail/widgets/add_animal_detail_header.dart';
import 'package:livestock/app/add_animal_detail/widgets/diagnosis_selection_widget.dart';
import 'package:livestock/app/add_animal_detail/widgets/health_status_selection_widget.dart';
import 'package:livestock/app/add_animal_detail/widgets/treatment_selection_widget.dart';
import 'package:livestock/app/animal_details/bloc/bloc.dart';
import 'package:livestock/src/ui/theming.dart';
import 'package:livestock/src/ui/widgets/livestock_primary_button.dart';

import 'bloc/bloc.dart';

class AddAnimalDetailDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddAnimalDetailDialogState();
}

class _AddAnimalDetailDialogState extends State<AddAnimalDetailDialog> {
  final _formKey = GlobalKey<FormState>();
  
  AddAnimalDetailBloc _addAnimalDetailBloc;
  TextEditingController _cageEditingController;

  @override
  void initState() {
    super.initState();

    _addAnimalDetailBloc = context.bloc<AddAnimalDetailBloc>();
    _cageEditingController = TextEditingController();
    _cageEditingController.addListener(_onCageNumberChanged);
    _cageEditingController.value = TextEditingValue(
      text: _addAnimalDetailBloc.state.cageDisplayValue,
      selection: TextSelection.fromPosition(
        TextPosition(offset: _addAnimalDetailBloc.state.cageDisplayValue?.length ?? 0),
      ),
    );
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
                  if (state.isSaved) {
                    Navigator.of(context).pop();

                    context.bloc<AnimalDetailsBloc>().add(
                          AnimalHealthStatusChanged(
                            animalNumber: state.animalNumber,
                            healthStatus: state.healthStatus,
                          ),
                        );
                  }
                },
                child: BlocBuilder<AddAnimalDetailBloc, AddAnimalDetailState>(
                  builder: (context, state) {
                    if (state.isSaved) {
                      return Container();
                    }

                    return Column(
                      children: <Widget>[
                        Expanded(
                          child: Form(
                            key: _formKey,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  AddAnimalDetailHeader(
                                    onClose: () => Navigator.of(context).pop(),
                                  ),
                                  ..._buildDateRow(state),
                                  ..._buildHealthStatusSelectionRow(state),
                                  ..._buildDiagnosisSelectionRow(state),
                                  ..._buildTreatmentSelectionRow(state),
                                ],
                              ),
                            ),
                          ),
                        ),
                        _buildBottomBar(state),
                      ],
                    );
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
    var saveAction = state.canSave ?
            () =>
              BlocProvider.of<AddAnimalDetailBloc>(context).add(
                SaveAnimalHistoryRecord(
                  stateToSave: state,
                ),
              )
            : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Divider(),
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: LivestockPrimaryButton(
            text: 'Opslaan',
            onPressed: saveAction,
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

  List<Widget> _buildDateRow(AddAnimalDetailState state) {
    return <Widget>[
      Divider(),
      Padding(
        padding: const EdgeInsets.only(
          top: 15.0,
          bottom: 15.0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Datum',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 14, bottom: 18),
                  child: Text(
                    state.registrationDateDisplayValue,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Hok',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(
                  width: 70,
                  child: TextField(
                    controller: _cageEditingController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          style: BorderStyle.solid,
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(0),
                      counter: Container(),
                    ),
                    maxLength: 3,
                    maxLengthEnforced: true,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: kDefaultTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            )
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

  @override
  void dispose() {
    _cageEditingController.dispose();
    super.dispose();
  }

  void _onCageNumberChanged() {
    _addAnimalDetailBloc.add(
      UpdateCageNumber(
        cage: _cageEditingController.text,
      ),
    );
  }
}
