import 'package:animalstat_repository/animalstat_repository.dart';
import 'package:date_picker/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../src/ui/theming.dart';
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
    return DefaultTabController(
      length: _tabs.length,
      child: Column(
        children: [
          _buildTabBar(),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, top: 16.0),
            child: _buildDatePicker(context),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: BlocBuilder<RecurringTreatmentsBloc,
                  RecurringTreatmentsState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return _buildTabBarView(state);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    final baseDate = DateTime.now();
    const defaultTextStyle = TextStyle(
      fontSize: 12,
    );
    const defaultSelectedTextStyle = TextStyle(
      color: Colors.white,
      fontSize: 12,
    );

    final firstDate = baseDate.subtract(const Duration(days: 7));
    final lastDate = baseDate.add(const Duration(days: 30));

    return DatePicker(
      dateStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      elementBackground: Colors.white,
      elementBorder: Border.all(
        color: kBorderColor,
        width: 1,
        style: BorderStyle.solid,
      ),
      elementBorderRadius: BorderRadius.circular(4),
      elementMargin: const EdgeInsets.only(left: 5, right: 5),
      firstDate: firstDate,
      monthStyle: defaultTextStyle,
      lastDate: lastDate,
      onDateSelected: (date) => context
          .read<RecurringTreatmentsBloc>()
          .add(SelectedDateChanged(selectedDate: date)),
      selectedDateStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      selectedElementBackground: Theme.of(context).primaryColor,
      selectedElementBorder: null,
      selectedMonthStyle: defaultSelectedTextStyle,
      selectedWeekDayStyle: defaultSelectedTextStyle,
      showDateSelector: true,
      weekDayStyle: defaultTextStyle,
      width: double.infinity,
    );
  }

  Widget _buildTabBarView(RecurringTreatmentsState state) {
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

        if (listItems.isEmpty) {
          return Center(
            child: Text(
              // ignore: lines_longer_than_80_chars
              'Er zijn ${state.selectedDateDisplayValue.toLowerCase()} geen behandelingen met de status "${tab.text.toLowerCase()}".',
            ),
          );
        }

        return ListView.builder(
          itemCount: listItems.length,
          itemBuilder: (context, index) {
            final listItem = listItems[index];
            if (listItem.type == RecurringTreatmentListItemTypes.header) {
              return RecurringTreatmentHeader(title: 'Hok ${listItem.cageId}');
            }

            final card = _buildTreatmentCard(listItem.recurringTreatment);

            if (tab.text.toUpperCase() == 'TE DOEN') {
              return _buildDismissibleTreatmentCard(
                context,
                card,
                listItem.recurringTreatment,
              );
            }

            return card;
          },
        );
      }).toList(),
    );
  }

  Widget _buildTabBar() {
    return AnimalstatAppBarBottom(
      child: TabBar(
        tabs: _tabs,
      ),
    );
  }

  Widget _buildDismissibleTreatmentCard(
    BuildContext context,
    Widget child,
    RecurringTreatmentCardState treatmentCardState,
  ) {
    return Dismissible(
      key: const Key("dismissible_widget"),
      child: child,
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
