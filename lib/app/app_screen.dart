import 'package:animalstat_repository/animalstat_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../src/ui/widgets/animalstat_search_text_field.dart';
import 'bottom_navigation/bloc/bottom_navigation_bloc.dart';
import 'recurring_treatments/bloc/recurring_treatment_bloc/recurring_treatments_bloc.dart';
import 'recurring_treatments/bloc/suspect_animal_overview_bloc/suspect_animal_overview_bloc.dart';
import 'recurring_treatments/recurring_treatments_screen.dart';
import 'search_animal/bloc/bloc.dart';
import 'search_animal/search_animals_screen.dart';

class AppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchAnimalBloc>(
          create: (context) => SearchAnimalBloc(
            animalRepository: context.read<AnimalRepository>(),
          ),
        ),
        BlocProvider<RecurringTreatmentsBloc>(
          create: (context) => RecurringTreatmentsBloc(
            recurringTreatmentsRepository:
                context.read<RecurringTreatmentsRepository>(),
          ),
        ),
        BlocProvider<SuspectAnimalOverviewBloc>(
          create: (context) => SuspectAnimalOverviewBloc(
            animalRepository: context.read<AnimalRepository>(),
          ),
        ),
      ],
      child: GestureDetector(
        onTap: () {
          final currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            leadingWidth: 0,
            titleSpacing: 0.0,
            title: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
              builder: (context, state) {
                switch (state.currentPage) {
                  case BottomNavigationEvent.treatmentsPage:
                    return const Text('Behandelingen');
                  case BottomNavigationEvent.animalsPage:
                    return Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: AnimalstatSearchTextField(
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        onChanged: (value) => context
                            .read<SearchAnimalBloc>()
                            .add(QueryChanged(query: value)),
                        hintText: 'Zoeken...',
                        height: 40,
                      ),
                    );
                  case BottomNavigationEvent.statisticsPage:
                    return const Text('Statistieken');
                }

                return Container();
              },
            ),
          ),
          body: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
            builder: (context, state) {
              switch (state.currentPage) {
                case BottomNavigationEvent.treatmentsPage:
                  return RecurringTreatmentsScreen();
                case BottomNavigationEvent.animalsPage:
                  return SearchAnimalScreen();
                case BottomNavigationEvent.statisticsPage:
                  return const Text('Statistieken');
              }

              return Container();
            },
          ),
          bottomNavigationBar:
              BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
                  builder: (context, state) {
            return BottomNavigationBar(
              currentIndex: state.currentPage.index,
              items: <BottomNavigationBarItem>[
                const BottomNavigationBarItem(
                  icon: Icon(Icons.assignment),
                  label: 'Behandelingen',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Dieren',
                ),
                //const BottomNavigationBarItem(
                //  icon: Icon(Icons.timeline),
                //  label: 'Statistieken',
                //),
              ],
              onTap: (index) => context.read<BottomNavigationBloc>().add(
                    BottomNavigationEvent.values[index],
                  ),
            );
          }),
        ),
      ),
    );
  }
}
