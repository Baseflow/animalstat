import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../decoration_factory.dart';
import '../theming.dart';

class AnimalstatTextFormField extends StatelessWidget {
  const AnimalstatTextFormField({
    Key key,
    this.autocorrect = true,
    this.autofocus = false,
    this.autovalidateMode,
    this.controller,
    this.decoration,
    this.hintText,
    this.keyboardType,
    this.labelText,
    this.maxLength,
    this.maxLengthEnforced = false,
    this.obscureText = false,
    this.prefixIcon,
    this.textInputAction,
    this.validator,
  });

  /// {@macro flutter.widgets.editableText.autocorrect}
  final bool autocorrect;

  /// {@macro flutter.widgets.editableText.autofocus}
  final bool autofocus;

  /// Used to enable/disable this form field auto validation and update its
  /// error text.
  final AutovalidateMode autovalidateMode;

  /// Controls the text being edited.
  final TextEditingController controller;

  /// The decoration to show around the text field.
  final InputDecoration decoration;

  /// Text that suggests what sort of input the field accepts.
  final String hintText;

  /// {@macro flutter.widgets.editableText.keyboardType}
  final TextInputType keyboardType;

  /// Text that describes the input field.
  final String labelText;

  /// The maximum number of characters (Unicode scalar values) to allow in the
  /// text field.
  final int maxLength;

  /// If true, prevents the field from allowing more than maxLength characters.
  final bool maxLengthEnforced;

  /// {@macro flutter.widgets.editableText.obscureText}
  final bool obscureText;

  /// An icon that appears before the prefix or prefixText and before the
  /// editable part of the text field, within the decoration's container.
  final Icon prefixIcon;

  /// The type of action button to use for the keyboard.
  ///
  /// Defaults to [TextInputAction.newline] if [keyboardType] is
  /// [TextInputType.multiline] and [TextInputAction.done] otherwise.
  final TextInputAction textInputAction;

  /// An optional method that validates an input. Returns an error string to
  /// display if the input is invalid, or null otherwise.
  final FormFieldValidator<String> validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
        boxShadow: [
          BoxShadow(
            color: kShadowColor,
            blurRadius: 5.0,
            offset: Offset(0.0, 1.0),
          ),
        ],
      ),
      child: TextFormField(
        autocorrect: autocorrect,
        autofocus: autofocus,
        autovalidateMode: autovalidateMode,
        controller: controller,
        decoration: decoration ??
            DecorationFactory.defaultTextFieldDecoration(
              hintText: hintText,
              labelText: labelText,
              prefixIcon: prefixIcon,
            ),
        keyboardType: keyboardType,
        maxLength: maxLength,
        maxLengthEnforced: maxLengthEnforced,
        obscureText: obscureText,
        textInputAction: textInputAction,
        validator: validator,
      ),
    );
  }
}
