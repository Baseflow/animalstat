import 'package:livestock/src/ui/theming.dart';
import 'package:flutter/material.dart';

class DecorationFactory {
  static InputDecoration DefaultTextFieldDecoration({
    String hintText,
    String labelText,
    Widget prefixIcon,
  }) {
    return InputDecoration(
      border: const OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
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

  static InputDecoration SearchTextFieldDecoration({
    String hintText,
    String labelText,
    Widget prefixIcon,
  }) {
    return InputDecoration(
      border: const OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        borderSide: BorderSide.none,
      ),
      counterText: '',
      fillColor: kPrimaryDarkColor,
      filled: true,
      hintText: hintText,
      labelText: labelText,
      prefixIcon: prefixIcon,
    );
  }

  static InputDecoration RectangleTextFieldDecoration({
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
