import 'package:animalstat/app/animal_details/bloc/bloc.dart';
import 'package:animalstat_repository/animalstat_repository.dart';
import 'package:flutter/material.dart';
import 'package:animalstat/src/ui/widgets/animalstat_health_status_label.dart';
import 'package:animalstat/src/utilities/enum_converters.dart';

class HistoryCard extends StatelessWidget {
  final AnimalHistoryCardState _historyCardState;

  HistoryCard({@required AnimalHistoryCardState historyCardState})
      : assert(historyCardState != null),
        _historyCardState = historyCardState;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(15.0, 0, 15, 10),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: _buildTitleColumn(),
                ),
                AnimalstatHealthStatusLabel(
                  healthStatus: _historyCardState.healthStatus,
                ),
              ],
            ),
            (_historyCardState.diagnosis != Diagnoses.none)
                ? Padding(
                    padding: const EdgeInsets.only(top: 17.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(child: _buildDiagnosesColumn()),
                        _buildTreatmentColumn(),
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          _historyCardState.seenOnDisplayValue,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        Text(
          _historyCardState.cageDisplayValue,
          style: TextStyle(
            fontSize: 17.0,
          ),
        ),
      ],
    );
  }

  Widget _buildDiagnosesColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Diagnose',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17.0,
          ),
        ),
        Text(
          EnumConverters.toDiagnosesDisplayValue(_historyCardState.diagnosis),
          style: TextStyle(
            fontSize: 17.0,
          ),
        ),
      ],
    );
  }

  Widget _buildTreatmentColumn() {
    if (_historyCardState.treatment == Treatments.none) {
      return Container();
    }

    return Column(
      children: <Widget>[
        Text(
          EnumConverters.toTreatmentDisplayValue(_historyCardState.treatment),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17.0,
          ),
        ),
      ],
    );
  }
}
