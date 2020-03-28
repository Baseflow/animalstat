import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:livestock/src/ui/widgets/livestock_number_box.dart';
import 'package:livestock_repository/livestock_repository.dart';
import 'package:flutter/material.dart';
import 'package:livestock/src/ui/widgets/livestock_health_status_label.dart';
import 'package:livestock/src/utilities/enum_converters.dart';

class RecurringTreatmentCard extends StatelessWidget {
  final RecurringTreatment recurringTreatment;

  RecurringTreatmentCard({@required this.recurringTreatment})
      : assert(recurringTreatment != null);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(15.0, 0, 15.0, 10),
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  LivestockNumberBox(
                    animalNumber: recurringTreatment.animalNumber.toString(),
                  ),
                  LivestockHealthStatusLabel(
                    healthStatus: recurringTreatment.healthStatus,
                  ),
                ],
              ),
              (recurringTreatment.diagnosis != Diagnoses.none)
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
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Toegediend',
            color: Colors.green,
            icon: FontAwesomeIcons.checkCircle,
            onTap: () => print('Toegediend'),
          ),
          IconSlideAction(
            caption: 'Stoppen',
            color: Colors.red,
            icon: FontAwesomeIcons.timesCircle,
            onTap: () => print('Gestopt'),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          recurringTreatment.administrationDate.toIso8601String(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        Text(
          recurringTreatment.diagnosis.toString(),
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
          EnumConverters.toDiagnosesDisplayValue(recurringTreatment.diagnosis),
          style: TextStyle(
            fontSize: 17.0,
          ),
        ),
      ],
    );
  }

  Widget _buildTreatmentColumn() {
    if (recurringTreatment.treatment == Treatments.none) {
      return Container();
    }

    return Column(
      children: <Widget>[
        Text(
          EnumConverters.toTreatmentDisplayValue(recurringTreatment.treatment),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17.0,
          ),
        ),
        Text(
          recurringTreatment.administrationDate.toIso8601String(),
        ),
      ],
    );
  }
}
