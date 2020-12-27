import 'package:animalstat/app/bottom_navigation/bloc/bottom_navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
          builder: (context, state) {
            switch (state.currentPage) {
              case BottomNavigationEvent.TreatmentsPage:
                return Text('Behandelingen');
              case BottomNavigationEvent.AnimalsPage:
                return Text('Dieren');
              case BottomNavigationEvent.StatisticsPage:
                return Text('Statistieken');
            }

            return Container();
          },
        ),
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
    );
  }
}
