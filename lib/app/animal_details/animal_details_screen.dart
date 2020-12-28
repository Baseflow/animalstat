import 'package:animalstat_repository/animalstat_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../src/ui/widgets/animalstat_number_box.dart';
import 'bloc/bloc.dart';
import 'widgets/animal_details_header.dart';
import 'widgets/history_card.dart';
import 'widgets/history_header.dart';

class AnimalDetailsScreen extends StatelessWidget {
  static MaterialPageRoute route(
    AnimalRepository animalRepository,
    int animalNumber,
  ) {
    return MaterialPageRoute(
      builder: (context) => RepositoryProvider.value(
        value: animalRepository,
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AnimalHistoryBloc>(
              create: (context) => AnimalHistoryBloc(
                animalNumber: animalNumber,
                animalRepository: context.read<AnimalRepository>(),
              )..add(
                  LoadHistory(
                    animalNumber: animalNumber,
                  ),
                ),
            ),
            BlocProvider<AnimalDetailsBloc>(
              create: (context) => AnimalDetailsBloc(
                animalNumber: animalNumber,
                animalRepository: context.read<AnimalRepository>(),
              )..add(
                  LoadAnimalDetails(
                    animalNumber: animalNumber,
                  ),
                ),
            ),
          ],
          child: AnimalDetailsScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocBuilder<AnimalHistoryBloc, AnimalHistoryState>(
          builder: (context, state) {
        return CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: HistoryHeader(animalNumber: state.animalNumber),
            ),
            if (state is HistoryUpdated)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return HistoryCard(
                      historyCardState: state.history[index],
                    );
                  },
                  childCount: state.history.length,
                ),
              ),
          ],
        );
      }),
    );
  }

  static Widget _buildAppBar(BuildContext context) {
    return AppBar(
      brightness: Brightness.dark,
      bottom: AnimalDetailsHeader(),
      elevation: 0.0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
      titleSpacing: 0.0,
      title: BlocBuilder<AnimalDetailsBloc, AnimalDetailsState>(
          builder: (context, state) {
        return (state is AnimalDetailsState)
            ? AnimalstatNumberBox(
                animalNumber: state.animalNumber.toString(),
              )
            : const Text('animalstat');
      }),
    );
  }
}
