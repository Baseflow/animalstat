import 'package:flutter/material.dart';
import 'package:livestock/src/ui/theming.dart';

class PrimaryButton extends StatelessWidget {
  final Icon _icon;
  final VoidCallback _onPressed;
  final String _text;

  PrimaryButton({
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
      style: Theme.of(context).textTheme.button.copyWith(color: Colors.white),
    );
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    );


    final button = (_icon != null)
        ? RaisedButton.icon(
            icon: _icon,
            shape: shape,
            onPressed: _onPressed,
            label: label,
            color: kPrimaryColor)
        : RaisedButton(
            shape: shape,
            onPressed: _onPressed,
            child: label,
            color: kPrimaryColor,
          );
    
    return SizedBox(
      child: button,
      height: 52,
    );
  }
}
