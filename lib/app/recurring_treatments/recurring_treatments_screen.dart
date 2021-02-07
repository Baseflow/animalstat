import 'package:animalstat_repository/animalstat_repository.dart';
import 'package:date_picker/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../src/ui/theming.dart';
import '../../src/ui/widgets/animalstat_appbar_bottom.dart';
import '../animal_details/animal_details_screen.dart';
import 'bloc/bloc.dart';
import 'bloc/models/models.dart';
import 'widgets/recurring_treatment_card.dart';
import 'widgets/recurring_treatment_header.dart';

class RecurringTreatmentsScreen extends StatefulWidget {
  @override
  _RecurringTreatmentsScreenState createState() =>
      _RecurringTreatmentsScreenState();
}

class _RecurringTreatmentsScreenState extends State<RecurringTreatmentsScreen>
    with SingleTickerProviderStateMixin {
  final List<Tab> _tabs = <Tab>[
    const Tab(text: 'TE DOEN'),
    const Tab(text: 'GEDAAN'),
    const Tab(text: 'GESTOPT'),
    const Tab(text: 'VERDACHT'),
  ];

  TabController _tabController;
  Tab _selectedTab;

  @override
  void initState() {
    _selectedTab = _tabs[0];

    _tabController = TabController(
      length: _tabs.length,
      vsync: this,
    );

    _tabController.addListener(() {
      final index = _tabController.index;

      setState(() {
        _selectedTab = _tabs[index];
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTabBar(),
        _buildTabView(),
      ],
    );
  }

  Widget _buildTabView() {
    return Expanded(
      child: Column(
        children: [
          if (_selectedTab != _tabs[3])
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, top: 16.0),
              child: _buildDatePicker(context),
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TabBarView(
                controller: _tabController,
                children: _tabs.map((tab) {
                  if (tab == _tabs[3]) {
                    return _buildSuspectOverview();
                  }

                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                    ),
                    child: _buildRecurringTreatment(context, tab),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecurringTreatment(BuildContext context, Tab tab) {
    return BlocBuilder<RecurringTreatmentsBloc, RecurringTreatmentsState>(
        builder: (context, state) {
      if (state.isLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      var listItems = <TreatmentListItem>[];

      if (tab == _tabs[0]) {
        listItems = state.openTreatments;
      } else if (tab == _tabs[1]) {
        listItems = state.appliedTreatments;
      } else if (tab == _tabs[2]) {
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
          if (listItem.type == TreatmentListItemTypes.header) {
            return RecurringTreatmentHeader(title: 'Hok ${listItem.cageId}');
          }

          final card = _buildTreatmentCard(listItem.treatmentCard);

          if (tab.text.toUpperCase() == 'TE DOEN') {
            return _buildDismissibleTreatmentCard(
              context,
              card,
              listItem.treatmentCard,
            );
          }

          return card;
        },
      );
    });
  }

  Widget _buildSuspectOverview() {
    return BlocBuilder<SuspectAnimalOverviewBloc, SuspectAnimalOverviewState>(
        builder: (context, state) {
      if (state.isLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state.isEmpty) {
        return const Center(
          child: Text(
            'Er zijn momenteel geen dieren verdacht.',
          ),
        );
      }

      return ListView.builder(
        itemCount: state.treatmentListItems.length,
        itemBuilder: (context, index) {
          final listItem = state.treatmentListItems[index];
          if (listItem.type == TreatmentListItemTypes.header) {
            return RecurringTreatmentHeader(title: 'Hok ${listItem.cageId}');
          }

          return Dismissible(
            key: const Key("dismissible_widget"),
            background: Container(
              child: const Center(
                child: Text(
                  'Gezond',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              color: const Color.fromRGBO(165, 214, 167, 1),
            ),
            child: _buildTreatmentCard(listItem.treatmentCard),
            onDismissed: (_) {
              context.read<SuspectAnimalOverviewBloc>().add(
                    SaveAnimal(
                        animalNumber: listItem.treatmentCard.animalNumber,
                        cage: listItem.cageId),
                  );
            },
          );
        },
      );
    });
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

  Widget _buildTabBar() {
    return AnimalstatAppBarBottom(
      child: TabBar(
        controller: _tabController,
        tabs: _tabs,
      ),
    );
  }

  Widget _buildDismissibleTreatmentCard(
    BuildContext context,
    Widget child,
    TreatmentCard treatmentCardState,
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

  Widget _buildTreatmentCard(TreatmentCard treatmentCardState) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        var animalRepository = context.read<AnimalRepository>();
        Navigator.of(context).push(
          AnimalDetailsScreen.route(
            animalRepository,
            treatmentCardState.animalNumber,
          ),
        );
      },
      child: RecurringTreatmentCard(recurringTreatment: treatmentCardState),
    );
  }
}
