import 'package:livestock/src/ui/decoration_factory.dart';
import 'package:livestock/src/ui/theming.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LivestockTextFormField extends StatelessWidget {
  const LivestockTextFormField({
    Key key,
    this.autocorrect = true,
    this.autofocus = false,
    this.autovalidate,
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

  /// If true, this form field will validate and update its error text immediately after every change. Otherwise, you must call FormFieldState.validate to validate. If part of a Form that auto-validates, this value will be ignored.
  final bool autovalidate;

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

  /// The maximum number of characters (Unicode scalar values) to allow in the text field.
  final int maxLength;

  /// If true, prevents the field from allowing more than maxLength characters.
  final bool maxLengthEnforced;

  /// {@macro flutter.widgets.editableText.obscureText}
  final bool obscureText;

  /// An icon that appears before the prefix or prefixText and before the editable part of the text field, within the decoration's container.
  final Icon prefixIcon;

  /// The type of action button to use for the keyboard.
  ///
  /// Defaults to [TextInputAction.newline] if [keyboardType] is
  /// [TextInputType.multiline] and [TextInputAction.done] otherwise.
  final TextInputAction textInputAction;

  /// An optional method that validates an input. Returns an error string to display if the input is invalid, or null otherwise.
  final FormFieldValidator<String> validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(16.0),
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
        autovalidate: autovalidate,
        controller: controller,
        decoration: decoration ?? DecorationFactory.DefaultTextFieldDecoration(
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
