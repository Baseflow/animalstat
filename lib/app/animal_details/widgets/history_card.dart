import 'package:flutter/material.dart';

import '../../../src/ui/widgets/animalstat_health_status_label.dart';
import '../models/animal_overview_item.dart';

class HistoryCard extends StatelessWidget {
  final AnimalOverviewCard _data;
  final IconData titleIcon;
  final IconData subtitleIcon;

  HistoryCard({
    @required AnimalOverviewCard data,
    this.titleIcon = Icons.home,
    this.subtitleIcon = Icons.assignment,
  })  : assert(data != null),
        _data = data;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(15.0, 0, 15, 10),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(titleIcon),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      '${_data.title}',
                      style: const TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                  ),
                ),
                if (_data.healthStatus != null)
                  AnimalstatHealthStatusLabel(
                    healthStatus: _data.healthStatus,
                  ),
              ],
            ),
            if (_data.subtitle != null) _buildSubtitleRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildSubtitleRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(subtitleIcon),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _data.subtitle,
                style: const TextStyle(
                  fontSize: 17.0,
                ),
              ),
              if (_data.text != null)
                Text(
                  _data.text,
                  style: const TextStyle(
                    fontSize: 14.0,
                  ),
                ),
            ],
          ),
        )),
      ],
    );
  }
}
