import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddAnimalDetailHeader extends StatelessWidget {
  final VoidCallback _onClose;

  const AddAnimalDetailHeader({
    Key key,
    VoidCallback onClose,
  }) : _onClose = onClose;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Expanded(
          child: Text(
            'Registratie maken',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(
            FontAwesomeIcons.times,
          ),
          onPressed: _onClose,
        ),
      ],
    );
  }
}
