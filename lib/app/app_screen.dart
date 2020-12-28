import 'package:animalstat/app/bottom_navigation/bloc/bottom_navigation_bloc.dart';
import 'package:animalstat/app/recurring_treatments/recurring_treatments_screen.dart';
import 'package:animalstat/app/search_animal/bloc/bloc.dart';
import 'package:animalstat/app/search_animal/search_animals_screen.dart';
import 'package:animalstat/src/ui/widgets/animalstat_search_text_field.dart';
import 'package:animalstat_repository/animalstat_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchAnimalBloc>(
      create: (context) => SearchAnimalBloc(
        animalRepository: context.read<AnimalRepository>(),
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leadingWidth: 0,
          titleSpacing: 0.0,
          title: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
            builder: (context, state) {
              switch (state.currentPage) {
                case BottomNavigationEvent.TreatmentsPage:
                  return Text('Behandelingen');
                case BottomNavigationEvent.AnimalsPage:
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
                case BottomNavigationEvent.StatisticsPage:
                  return Text('Statistieken');
              }

              return Container();
            },
          ),
        ),
        body: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
          builder: (context, state) {
            switch (state.currentPage) {
              case BottomNavigationEvent.TreatmentsPage:
                return RecurringTreatmentsScreen();
              case BottomNavigationEvent.AnimalsPage:
                return SearchAnimalScreen();
              case BottomNavigationEvent.StatisticsPage:
                return Text('Statistieken');
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
              BottomNavigationBarItem(
                icon: Icon(Icons.assignment),
                label: 'Behandelingen',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Dieren',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.timeline),
                label: 'Statistieken',
              ),
            ],
            onTap: (index) => context.read<BottomNavigationBloc>().add(
                  BottomNavigationEvent.values[index],
                ),
          );
        }),
      ),
    );
  }
}
