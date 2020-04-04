import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:livestock/app/add_history_record/add_history_record_dialog.dart';
import 'package:livestock/app/add_history_record/bloc/bloc.dart';
import 'package:livestock/app/animal_details/bloc/animal_details_bloc/animal_details_bloc.dart';
import 'package:livestock/src/ui/theming.dart';
import 'package:livestock/src/ui/widgets/livestock_primary_button.dart';
import 'package:livestock_repository/livestock_repository.dart';

class HistoryHeader extends StatelessWidget {
  HistoryHeader({@required this.animalNumber});

  final int animalNumber;

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
              FontAwesomeIcons.plus,
              size: 16,
              color: kWhite,
            ),
            text: 'Toevoegen',
            onPressed: () => _addDetailButtonPressed(context),
          ),
        ],
      ),
    );
  }

  void _addDetailButtonPressed(BuildContext context) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(value: context.bloc<AnimalDetailsBloc>()),
              BlocProvider(
                create: (context) => AddHistoryRecordBloc(
                  animalNumber: animalNumber,
                  animalRepository: context.repository<AnimalRepository>(),
                ),
              ),
            ],
            child: AddHistoryRecordDialog(),
          );
        });
  }
}
