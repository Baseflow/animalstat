import 'package:flutter/material.dart';

import '../theming.dart';

class AnimalstatNumberBox extends StatelessWidget {
  final String animalNumber;

  const AnimalstatNumberBox({this.animalNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(7.0),
        ),
        color: kAnimalNumberBackgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10.0,
          right: 10.0,
          top: 5.0,
          bottom: 5.0,
        ),
        child: Text(
          animalNumber,
          style: const TextStyle(
            color: kWhite,
            fontSize: 22.0,
            fontFamily: 'Courier',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
