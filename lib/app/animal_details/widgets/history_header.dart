import 'package:flutter/material.dart';
import 'package:livestock/app/add_animal_detail/add_animal_detail_dialog.dart';
import 'package:livestock/src/ui/theming.dart';
import 'package:livestock/src/ui/widgets/livestock_primary_button.dart';

class HistoryHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        top: 25.0,
        right: 15.0,
        bottom: 25.0,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Text(
              'Registraties',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          LivestockPrimaryButton(
            icon: Icon(
              Icons.add,
              color: kWhite,
            ),
            text: 'Toevoegen',
            onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) => AddAnimalDetailDialog()
            ),
          ),
        ],
      ),
    );
  }
}
