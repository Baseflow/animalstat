import 'package:animalstat/src/ui/widgets/animalstat_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animalstat/app/recurring_treatments/widgets/recurring_treatment_card.dart';
import 'package:animalstat/app/recurring_treatments/widgets/recurring_treatment_header.dart';
import 'package:animalstat/src/ui/theming.dart';
import 'package:animalstat/src/ui/widgets/animalstat_appbar_bottom.dart';
import 'package:animalstat_repository/animalstat_repository.dart';
import '../../src/extensions/date_time_extensions.dart';

import 'bloc/recurring_treatments_bloc.dart';

class RecurringTreatmentsScreen extends StatefulWidget {
  static MaterialPageRoute route() {
    return MaterialPageRoute(
      builder: (context) => RecurringTreatmentsScreen(),
    );
  }

  @override
  _RecurringTreatmentsScreenState createState() =>
      _RecurringTreatmentsScreenState();
}

class _RecurringTreatmentsScreenState extends State<RecurringTreatmentsScreen> {
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
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: kSecondaryColor,
        ),
        child: Scaffold(
          appBar: _buildAppBar(context),
          body: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: BlocBuilder<RecurringTreatmentsBloc, RecurringTreatmentsState>(
                builder: (BuildContext context, RecurringTreatmentsState state) {
              if (state.notFound) {
                return _buildMessage(
                  context,
                  'Geen behandelingen voor ${state.selectedDateDisplayValue.toLowerCase()}.',
                );
              }

              if (state.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return CustomScrollView(
                slivers: <Widget>[
                  RecurringTreatmentHeader(
                    title: 'Openstaande behandelingen',
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Dismissible(
                          key: Key("dismissible_widget"),
                          child: RecurringTreatmentCard(
                            recurringTreatment: state.openTreatments[index],
                          ),
                          background: Container(
                            child: Icon(FontAwesomeIcons.checkCircle),
                            color: Colors.green,
                          ),
                          secondaryBackground: Container(
                            child: Icon(FontAwesomeIcons.timesCircle),
                            color: Colors.red,
                          ),
                          onDismissed: (direction) {
                            final treatmentStatus =
                                direction == DismissDirection.endToStart
                                    ? TreatmentStates.cancelled
                                    : TreatmentStates.done;

                            context
                                .bloc<RecurringTreatmentsBloc>()
                                .add(UpdateTreatment(
                                  treatmentStatus: treatmentStatus,
                                  cardState: state.openTreatments[index],
                                ));
                          },
                        );
                      },
                      childCount: state.openTreatments.length,
                    ),
                  ),
                  RecurringTreatmentHeader(
                    title: 'Uitgevoerde behandelingen',
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return RecurringTreatmentCard(
                          recurringTreatment: state.appliedTreatments[index],
                        );
                      },
                      childCount: state.appliedTreatments.length,
                    ),
                  ),
                  RecurringTreatmentHeader(
                    title: 'Gestopte behandelingen',
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return RecurringTreatmentCard(
                          recurringTreatment: state.cancelledTreatments[index],
                        );
                      },
                      childCount: state.cancelledTreatments.length,
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      brightness: Brightness.light,
      elevation: 0.0,
      titleSpacing: 0.0,
      title: Text(
        'Behandelingen',
        style: TextStyle(
          color: kDefaultTextColor,
        ),
      ),
      actions: <Widget>[
        AnimalstatMenu(),
      ],
      bottom: _buildAppBarBottom(context),
    );
  }

  Widget _buildAppBarBottom(BuildContext context) {
    return AnimalstatAppBarBottom(
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: BlocBuilder<RecurringTreatmentsBloc, RecurringTreatmentsState>(
            builder: (context, state) {
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
                  (selectedDate) {
                    if (selectedDate == null) {
                      return;
                    }

                    context.bloc<RecurringTreatmentsBloc>().add(
                          SelectedDateChanged(
                            selectedDate: selectedDate,
                          ),
                        );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildMessage(BuildContext context, String message) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Text(
          message,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 16.0,
          ),
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
