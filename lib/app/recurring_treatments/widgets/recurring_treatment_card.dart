import 'package:animalstat/src/ui/widgets/note_widget.dart';
import 'package:flutter/material.dart';

import '../../../src/ui/widgets/animalstat_health_status_label.dart';
import '../../../src/ui/widgets/animalstat_number_box.dart';
import '../bloc/models/models.dart';

class RecurringTreatmentCard extends StatelessWidget {
  final TreatmentCard recurringTreatment;

  RecurringTreatmentCard({@required this.recurringTreatment})
      : assert(recurringTreatment != null);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 10),
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
            if (recurringTreatment.diagnosis != null)
              Padding(
                padding: const EdgeInsets.only(top: 17.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.assignment, color: Colors.grey[700]),
                    const SizedBox(width: 8),
                    Expanded(child: _buildHealthDetailsColumn())
                  ],
                ),
              ),
            if (recurringTreatment.note != null &&
                recurringTreatment.note.isNotEmpty)
              _buildNoteWidget(recurringTreatment.note),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthDetailsColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        (recurringTreatment.treatment != null)
            ? Text(
                recurringTreatment.treatment,
                style: const TextStyle(
                  fontSize: 17.0,
                ),
              )
            : Container(),
        Text(
          recurringTreatment.diagnosis,
          style: const TextStyle(
            fontSize: 14.0,
          ),
        ),
      ],
    );
  }

  Widget _buildNoteWidget(String note) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: NoteWidget(
          child: Text(
        note,
        textAlign: TextAlign.left,
      )),
    );
  }
}
