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
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              'Registraties',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              FontAwesomeIcons.times,
            ),
            onPressed: _onClose,
          ),
        ],
      ),
    );
  }
}
