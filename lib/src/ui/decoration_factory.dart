import 'package:flutter/material.dart';

import 'theming.dart';

class DecorationFactory {
  static InputDecoration defaultTextFieldDecoration({
    String hintText,
    String labelText,
    Widget prefixIcon,
  }) {
    return InputDecoration(
      counterText: '',
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
    const border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
      borderSide: BorderSide(color: kBorderColor, width: 1),
    );

    return InputDecoration(
      border: border,
      enabledBorder: border,
      focusedBorder: border,
      counterText: '',
      hintText: hintText,
      labelText: labelText,
      contentPadding: const EdgeInsets.all(0),
      prefixIcon: prefixIcon ??
          const Icon(
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
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.zero,
      ),
      counterText: '',
      hintText: hintText,
      labelText: labelText,
      prefixIcon: prefixIcon,
    );
  }
}
