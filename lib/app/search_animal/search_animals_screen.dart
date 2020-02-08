import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livestock/app/animal_details/animal_details_screen.dart';
import 'package:livestock/app/animal_details/bloc/bloc.dart';
import 'package:livestock/app/search_animal/bloc/bloc.dart';
import 'package:livestock/app/search_animal/bloc/search_animal_state.dart';
import 'package:livestock/src/ui/theming.dart';
import 'package:livestock/src/ui/widgets/livestock_appbar_bottom.dart';
import 'package:livestock/src/ui/widgets/livestock_health_status_label.dart';
import 'package:livestock/src/ui/widgets/livestock_number_box.dart';
import 'package:livestock/src/ui/widgets/livestock_search_text_field.dart';
import 'package:livestock_repository/livestock_repository.dart';

class SearchAnimalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
              BlocProvider.of<SearchAnimalBloc>(context)
                  .add(QueryChanged(query: ''));
            },
          ),
        ],
        brightness: Brightness.dark,
        leading: Container(),
        bottom: _buildAppBarBottom(context),
        elevation: 0.0,
        titleSpacing: 0.0,
        title: Text('Livestock'),
      ),
      body: BlocBuilder<SearchAnimalBloc, SearchAnimalState>(
        builder: (BuildContext context, SearchAnimalState state) {
          if (state.isSearching) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.notFound) {
            return _buildMessage(
              context,
              'Geen resultaten gevonden.',
            );
          }

          if (state.isEmpty) {
            return _buildMessage(
              context,
              'Vul een diernummer in om een dier te zoeken.',
            );
          }

          if (!state.isQueryValid) {
            return _buildMessage(
              context,
              'Het ingevoerde nummer "${state.query}" bevat illegale characters.',
            );
          }

          return ListView.builder(
            itemBuilder: (context, index) =>
                _buildResultRow(context, state.searchResults[index]),
            itemCount: state.searchResults.length,
          );
        },
      ),
    );
  }

  Widget _buildAppBarBottom(BuildContext context) {
    return LivestockAppBarBottom(
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: LivestockSearchTextField(
          autofocus: true,
          keyboardType: TextInputType.number,
          onChanged: (value) => BlocProvider.of<SearchAnimalBloc>(context)
              .add(QueryChanged(query: value)),
        ),
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

  Widget _buildResultRow(
      BuildContext context, AnimalSearchResult searchResult) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: getAnimalDetailProviders(
              searchResult.animalNumber,
              context,
            ),
            child: AnimalDetailsScreen(),
          ),
        ));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: kBorderColor,
            ),
          ),
          color: kWhite,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            top: 15.0,
            right: 15.0,
            bottom: 15.0,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              LivestockNumberBox(
                animalNumber: searchResult.animalNumber.toString(),
              ),
              Expanded(
                child: Container(),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: LivestockHealthStatusLabel(
                  healthStatus: searchResult.currentHealthStatus,
                ),
              ),
              Icon(
                Icons.chevron_right,
              )
            ],
          ),
        ),
      ),
    );
  }

  List<BlocProvider> getAnimalDetailProviders(
    int animalNumber,
    BuildContext context,
  ) =>
      [
        BlocProvider<AnimalHistoryBloc>(
            builder: (_) => AnimalHistoryBloc(
                  animalNumber: animalNumber,
                  animalRepository:
                      RepositoryProvider.of<AnimalRepository>(context),
                )..add(LoadHistory(animalNumber: animalNumber))),
        BlocProvider<AnimalDetailsBloc>(
          builder: (_) => AnimalDetailsBloc(
            animalNumber: animalNumber,
            animalRepository: RepositoryProvider.of<AnimalRepository>(context),
          )..add(LoadAnimalDetails(animalNumber: animalNumber)),
        ),
      ];
}
