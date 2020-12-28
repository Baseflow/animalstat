import 'package:animalstat_repository/animalstat_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../src/ui/widgets/animalstat_appbar_bottom.dart';
import 'bloc/recurring_treatment_list_item.dart';
import 'bloc/recurring_treatments_bloc.dart';
import 'widgets/recurring_treatment_card.dart';
import 'widgets/recurring_treatment_header.dart';

class RecurringTreatmentsScreen extends StatelessWidget {
  final List<Tab> _tabs = <Tab>[
    const Tab(text: 'TE DOEN'),
    const Tab(text: 'GEDAAN'),
    const Tab(text: 'GESTOPT'),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RecurringTreatmentsBloc>(
      create: (context) => RecurringTreatmentsBloc(
        recurringTreatmentsRepository:
            context.read<RecurringTreatmentsRepository>(),
      ),
      child: DefaultTabController(
        length: _tabs.length,
        child: Column(
          children: [
            _buildTabBar(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: BlocBuilder<RecurringTreatmentsBloc,
                    RecurringTreatmentsState>(builder: (context, state) {
                  if (state.notFound) {
                    return _buildMessage(
                      context,
                      // ignore: lines_longer_than_80_chars
                      'Geen behandelingen voor ${state.selectedDateDisplayValue.toLowerCase()}.',
                    );
                  }

                  if (state.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return TabBarView(
                    children: _tabs.map((tab) {
                      var listItems = <RecurringTreatmentListItem>[];

                      if (tab.text.toUpperCase() == 'TE DOEN') {
                        listItems = state.openTreatments;
                      } else if (tab.text.toUpperCase() == 'GEDAAN') {
                        listItems = state.appliedTreatments;
                      } else if (tab.text.toUpperCase() == 'GESTOPT') {
                        listItems = state.cancelledTreatments;
                      }

                      return ListView.builder(
                        itemCount: listItems.length,
                        itemBuilder: (context, index) {
                          final listItem = listItems[index];
                          if (listItem.type ==
                              RecurringTreatmentListItemTypes.header) {
                            return RecurringTreatmentHeader(
                                title: 'Hok ${listItem.cageId}');
                          }

                          if (tab.text.toUpperCase() == 'TE DOEN') {
                            return _buildDismissableTreatmentCard(
                              context,
                              listItem.recurringTreatment,
                            );
                          }

                          return _buildTreatmentCard(
                            listItem.recurringTreatment,
                          );
                        },
                      );
                    }).toList(),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return AnimalstatAppBarBottom(
      child: TabBar(
        tabs: _tabs,
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
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 16.0,
          ),
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildDismissableTreatmentCard(
    BuildContext context,
    RecurringTreatmentCardState treatmentCardState,
  ) {
    return Dismissible(
      key: const Key("dismissible_widget"),
      child: RecurringTreatmentCard(
        recurringTreatment: treatmentCardState,
      ),
      background: Container(
        child: const Icon(FontAwesomeIcons.timesCircle),
        color: Colors.red,
      ),
      secondaryBackground: Container(
        child: const Icon(FontAwesomeIcons.checkCircle),
        color: Colors.green,
      ),
      onDismissed: (direction) {
        final treatmentStatus = direction == DismissDirection.endToStart
            ? TreatmentStates.done
            : TreatmentStates.cancelled;

        context.read<RecurringTreatmentsBloc>().add(UpdateTreatment(
              treatmentStatus: treatmentStatus,
              cardState: treatmentCardState,
            ));
      },
    );
  }

  Widget _buildTreatmentCard(RecurringTreatmentCardState treatmentCardState) {
    return RecurringTreatmentCard(recurringTreatment: treatmentCardState);
  }
}
