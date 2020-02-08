import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livestock/app/animal_details/bloc/bloc.dart';
import 'package:livestock/app/animal_details/widgets/animal_details_header.dart';
import 'package:livestock/app/animal_details/widgets/history_card.dart';
import 'package:livestock/app/animal_details/widgets/history_header.dart';
import 'package:livestock/src/ui/widgets/livestock_number_box.dart';
import 'package:livestock_repository/livestock_repository.dart';

class AnimalDetailsScreen extends StatelessWidget {
  static MaterialPageRoute route(int animalNumber) {
    return MaterialPageRoute(
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider<AnimalHistoryBloc>(
            builder: (_) => AnimalHistoryBloc(
              animalNumber: animalNumber,
              animalRepository:
                  RepositoryProvider.of<AnimalRepository>(context),
            )..add(
                LoadHistory(
                  animalNumber: animalNumber,
                ),
              ),
          ),
          BlocProvider<AnimalDetailsBloc>(
            builder: (_) => AnimalDetailsBloc(
              animalNumber: animalNumber,
              animalRepository:
                  RepositoryProvider.of<AnimalRepository>(context),
            )..add(
                LoadAnimalDetails(
                  animalNumber: animalNumber,
                ),
              ),
          ),
        ],
        child: AnimalDetailsScreen(),
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
            ? LivestockNumberBox(
                animalNumber: state.animalNumber.toString(),
              )
            : Text('Livestock');
      }),
    );
  }
}
