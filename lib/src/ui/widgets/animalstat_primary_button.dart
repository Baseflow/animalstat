import 'package:animalstat/src/ui/theming.dart';
import 'package:flutter/material.dart';

class AnimalstatPrimaryButton extends StatelessWidget {
  final Icon _icon;
  final VoidCallback _onPressed;
  final String _text;

  AnimalstatPrimaryButton({
    Key key,
    Icon icon,
    String text,
    VoidCallback onPressed,
  })  : _icon = icon,
        _text = text,
        _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final label = Text(
      _text.toUpperCase(),
    );

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4.0),
    );

    final button = _icon != null
        ? RaisedButton.icon(
            onPressed: _onPressed,
            label: label,
            icon: _icon,
            // TODO: Create PR to add possibility to make the text white with theming
            // raised_button.dart:241
            // button_theme:642
            textColor: Colors.white,
            color: kPrimary,
          )
        : RaisedButton(
            shape: shape,
            onPressed: _onPressed,
            child: label,
            // TODO: Create PR to add possibility to make the text white with theming
            // raised_button.dart:241
            // button_theme:642
            textColor: Colors.white,
            color: kPrimary,
          );

    return SizedBox(
      child: button,
      height: 52,
    );
  }
}
