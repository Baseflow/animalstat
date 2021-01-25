import 'package:flutter/material.dart';

class AnimalstatSecondaryButton extends StatelessWidget {
  final Icon _icon;
  final VoidCallback _onPressed;
  final String _text;

  AnimalstatSecondaryButton({
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

    final button = (_icon != null)
        ? FlatButton.icon(
            onPressed: _onPressed,
            label: label,
            icon: _icon,
          )
        : FlatButton(
            onPressed: _onPressed,
            child: label,
          );

    return SizedBox(
      child: button,
      height: 52,
    );
  }
}
