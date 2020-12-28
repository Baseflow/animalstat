import 'package:flutter/material.dart';

class RecurringTreatmentHeader extends StatelessWidget {
  final String title;

  RecurringTreatmentHeader({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(Icons.home),
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
