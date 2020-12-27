import 'package:animalstat/app/animal_details/bloc/bloc.dart';
import 'package:animalstat/app/animal_details/widgets/animal_details_header.dart';
import 'package:animalstat/app/animal_details/widgets/history_card.dart';
import 'package:animalstat/app/animal_details/widgets/history_header.dart';
import 'package:animalstat/src/ui/widgets/animalstat_number_box.dart';
import 'package:animalstat_repository/animalstat_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          builder: (BuildContext context, AnimalHistoryState state) {
        return CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: HistoryHeader(animalNumber: state.animalNumber),
            ),
            if (state is HistoryUpdated)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
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
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
      titleSpacing: 0.0,
      title: BlocBuilder<AnimalDetailsBloc, AnimalDetailsState>(
          builder: (BuildContext context, AnimalDetailsState state) {
        return (state is AnimalDetailsState)
            ? AnimalstatNumberBox(
                animalNumber: state.animalNumber.toString(),
              )
            : Text('animalstat');
      }),
    );
  }
}
