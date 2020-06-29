import 'package:animalstat/src/ui/theming.dart';
import 'package:flutter/material.dart';

class DecorationFactory {
  static InputDecoration defaultTextFieldDecoration({
    String hintText,
    String labelText,
    Widget prefixIcon,
  }) {
    return InputDecoration(
      border: const OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        borderSide: BorderSide.none,
      ),
      counterText: '',
      fillColor: kWhite,
      filled: true,
      hintText: hintText,
      labelText: labelText,
      prefixIcon: prefixIcon,
    );
  }

  static InputDecoration searchTextFieldDecoration({
    String hintText,
    String labelText,
    Widget prefixIcon,
  }) {
    const border = const OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(4.0)),
      borderSide: const BorderSide(color: kBorderColor, width: 1),
    );

    return InputDecoration(
      border: border,
      enabledBorder: border,
      focusedBorder: border,
      counterText: '',
      fillColor: Colors.white,
      filled: true,
      hintText: hintText,
      labelText: labelText,
      contentPadding: EdgeInsets.all(0),
      prefixIcon: prefixIcon ??
          Icon(
            Icons.search,
            color: kDefaultTextColor,
          ),
    );
  }

  static InputDecoration rectangleTextFieldDecoration({
    String hintText,
    String labelText,
    Widget prefixIcon,
  }) {
    return InputDecoration(
      border: const OutlineInputBorder(
          borderSide: BorderSide.none, borderRadius: BorderRadius.zero),
      counterText: '',
      fillColor: kWhite,
      filled: true,
      hintText: hintText,
      labelText: labelText,
      prefixIcon: prefixIcon,
    );
  }
}
