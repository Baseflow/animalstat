import 'package:animal_repository/animal_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:livestock/src/ui/widgets/livestock_health_status_label.dart';
import 'package:livestock/src/utilities/enum_converters.dart';

class HistoryCard extends StatelessWidget {
  final AnimalHistoryRecord _animalHistoryRecord;

  HistoryCard({@required AnimalHistoryRecord historyRecord})
      : assert(historyRecord != null),
        _animalHistoryRecord = historyRecord;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(15.0, 0, 15, 10),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    DateFormat('dd-MM-yyyy')
                        .format(_animalHistoryRecord.seenOn),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                LivestockHealthStatusLabel(
                  healthStatus: _animalHistoryRecord.healthStatus,
                ),
              ],
            ),
            (_animalHistoryRecord.diagnosis != Diagnoses.none)
                ? Padding(
                    padding: const EdgeInsets.only(top: 17.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded( child: _buildDiagnosesColumn()),
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
          EnumConverters.toDiagnosesDisplayValue(
              _animalHistoryRecord.diagnosis),
          style: TextStyle(
            fontSize: 17.0,
          ),
        ),
      ],
    );
  }

  Widget _buildTreatmentColumn() {
    if (_animalHistoryRecord.treatment == Treatments.none) {
      return Container();
    }

    return Column(
      children: <Widget>[
        Text(
          EnumConverters.toTreatmentDisplayValue(
              _animalHistoryRecord.treatment),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17.0,
          ),
        ),
      ],
    );
  }
}
