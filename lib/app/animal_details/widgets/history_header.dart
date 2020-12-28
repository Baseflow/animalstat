import 'package:animalstat_repository/animalstat_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../src/ui/widgets/animalstat_primary_button.dart';
import '../../add_history_record/add_history_record_dialog.dart';
import '../../add_history_record/bloc/bloc.dart';
import '../bloc/animal_details_bloc/animal_details_bloc.dart';

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
          const Expanded(
            child: Text(
              'Registraties',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          AnimalstatPrimaryButton(
            icon: const Icon(
              FontAwesomeIcons.plus,
              size: 16,
            ),
            text: 'Toevoegen',
            onPressed: () => _addDetailButtonPressed(context),
          ),
        ],
      ),
    );
  }

  void _addDetailButtonPressed(BuildContext context) {
    var animalRepository = context.read<AnimalRepository>();
    //ignore: close_sinks
    var animalDetailsBloc = context.read<AnimalDetailsBloc>();
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return RepositoryProvider.value(
            value: animalRepository,
            child: MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: animalDetailsBloc,
                ),
                BlocProvider(
                  create: (context) => AddHistoryRecordBloc(
                    animalNumber: animalNumber,
                    animalRepository: context.read<AnimalRepository>(),
                  ),
                ),
              ],
              child: AddHistoryRecordDialog(),
            ),
          );
        });
  }
}
