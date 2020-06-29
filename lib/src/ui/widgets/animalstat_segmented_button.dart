import 'package:flutter/material.dart';

class AnimalstatSegmentedButton extends StatelessWidget {
  final Color borderColor;
  final Color backgroundColor;
  final Color textColor;
  final String text;

  const AnimalstatSegmentedButton({
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.text
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(17.0)),
        border: Border.all(
                color: borderColor ?? backgroundColor,
                width: 2
              ),
        color: backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15.0,
          right: 15.0,
          top: 7.0,
          bottom: 7.0,
        ),
        child: Text(
          text,
          style: TextStyle(
              color: textColor,
              fontSize: 15.0,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}