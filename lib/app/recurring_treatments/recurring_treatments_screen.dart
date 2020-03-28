import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livestock/app/authentication/bloc/bloc.dart';
import 'package:livestock/app/recurring_treatments/widgets/recurring_treatment_card.dart';
import 'package:livestock/app/search_animal/search_animals_screen.dart';
import 'package:livestock/src/ui/theming.dart';
import 'package:livestock/src/ui/widgets/livestock_appbar_bottom.dart';
import 'package:livestock_repository/livestock_repository.dart';
import '../../src/extensions/date_time_extensions.dart';

import 'bloc/recurring_treatments_bloc.dart';

class RecurringTreatmentsScreen extends StatelessWidget {
  static MaterialPageRoute route() {
    return MaterialPageRoute(
      builder: (context) => RecurringTreatmentsScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RecurringTreatmentsBloc>(
      create: (context) => RecurringTreatmentsBloc(
        recurringTreatmentsRepository:
            context.repository<RecurringTreatmentsRepository>(),
      )..add(
          LoadTreatments(
            selectedDate: DateTime.now().toDate(),
          ),
        ),
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: BlocBuilder<RecurringTreatmentsBloc, RecurringTreatmentsState>(
              builder: (BuildContext context, RecurringTreatmentsState state) {
            if (state.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return RecurringTreatmentCard(
                        recurringTreatment: state.treatments[index],
                      );
                    },
                    childCount: state.treatments.length,
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      brightness: Brightness.dark,
      elevation: 0.0,
      titleSpacing: 0.0,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.exit_to_app,
                ),
                onPressed: () =>
                    context.bloc<AuthenticationBloc>().add(LoggedOut()),
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: Text('Behandelingen'),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).push(
                SearchAnimalScreen.route(),
              );
            }),
      ],
      bottom: _buildAppBarBottom(context),
    );
  }

  Widget _buildAppBarBottom(BuildContext context) {
    return LivestockAppBarBottom(
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: BlocBuilder<RecurringTreatmentsBloc, RecurringTreatmentsState>(
            builder: (context, state) {
          if (state is RecurringTreatmentsState) {
            return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  child: Text(
                    state.selectedDateDisplayValue,
                    style: TextStyle(
                      color: kWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  onTap: () => showDatePicker(
                    context: context,
                    initialDate: state.selectedDate,
                    firstDate: DateTime(DateTime.now().year - 2),
                    lastDate: DateTime.now().add(
                      Duration(days: 360),
                    ),
                  ).then(
                    (selectedDate) =>
                        context.bloc<RecurringTreatmentsBloc>().add(
                              SelectedDateChanged(
                                selectedDate: selectedDate,
                              ),
                            ),
                  ),
                ),
              ],
            );
          }

          return Container();
        }),
      ),
    );
  }
}
