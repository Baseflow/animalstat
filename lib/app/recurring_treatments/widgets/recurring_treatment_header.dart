import 'package:flutter/material.dart';

class RecurringTreatmentHeader extends StatelessWidget {
  final String title;

  RecurringTreatmentHeader({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17.0,
          ),
        ),
      ),
    );
  }
}
