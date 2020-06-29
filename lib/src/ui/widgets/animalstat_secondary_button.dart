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
    final theme = Theme.of(context);
    final borderSide = BorderSide(
      color: theme.buttonColor,
    );
    final color = theme.buttonColor;
    final label = Text(
      _text.toUpperCase(),
      style: theme.textTheme.button.copyWith(
        color: theme.buttonColor,
        fontSize: 16,
      ),
      textAlign: TextAlign.center,
    );
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
    );

    final button = (_icon != null)
        ? OutlineButton.icon(
            borderSide: borderSide,
            shape: shape,
            onPressed: _onPressed,
            label: label,
            icon: _icon,
            color: color,
          )
        : OutlineButton(
            borderSide: borderSide,
            shape: shape,
            onPressed: _onPressed,
            child: label,
            color: color,
          );

    return SizedBox(
      child: button,
      height: 52,
    );
  }
}
