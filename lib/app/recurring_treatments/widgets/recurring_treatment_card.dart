import 'package:animalstat/app/recurring_treatments/bloc/recurring_treatments_bloc.dart';
import 'package:animalstat/src/ui/widgets/animalstat_number_box.dart';
import 'package:animalstat_repository/animalstat_repository.dart';
import 'package:flutter/material.dart';
import 'package:animalstat/src/ui/widgets/animalstat_health_status_label.dart';
import 'package:animalstat/src/utilities/enum_converters.dart';

class RecurringTreatmentCard extends StatelessWidget {
  final RecurringTreatmentCardState recurringTreatment;

  RecurringTreatmentCard({@required this.recurringTreatment})
      : assert(recurringTreatment != null);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(15.0, 0, 15.0, 10),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                AnimalstatNumberBox(
                  animalNumber: recurringTreatment.animalNumber.toString(),
                ),
                AnimalstatHealthStatusLabel(
                  healthStatus: recurringTreatment.healthStatus,
                ),
              ],
            ),
            (recurringTreatment.diagnosis != Diagnoses.none)
                ? Padding(
                    padding: const EdgeInsets.only(top: 17.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.assignment, color: Colors.grey[700]),
                        SizedBox(width: 15),
                        Expanded(child: _buildHealthDetailsColumn())
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthDetailsColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        (recurringTreatment.diagnosis != Diagnoses.none)
            ? Text(
                EnumConverters.toTreatmentDisplayValue(
                    recurringTreatment.treatment),
                style: TextStyle(
                  fontSize: 17.0,
                ),
              )
            : Container(),
        Text(
          EnumConverters.toDiagnosesDisplayValue(recurringTreatment.diagnosis),
          style: TextStyle(
            fontSize: 14.0,
          ),
        ),
      ],
    );
  }
}
