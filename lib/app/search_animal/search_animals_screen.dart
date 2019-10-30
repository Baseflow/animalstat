import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livestock/app/search_animal/bloc/bloc.dart';
import 'package:livestock/app/search_animal/bloc/search_animal_state.dart';
import 'package:livestock/src/ui/theming.dart';
import 'package:livestock/src/ui/widgets/livestock_search_text_field.dart';
import 'package:animal_repository/animal_repository.dart';

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
              BlocProvider.of<SearchAnimalBloc>(context).add(QueryChanged(query: ''));
            },
          ),
        ],
        brightness: Brightness.dark,
        leading: Container(),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(79.0),
          child: Center(
            child: Container(
              color: kAccentColor,
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: LivestockSearchTextField(
                  onChanged: (value) => BlocProvider.of<SearchAnimalBloc>(context).add(QueryChanged(query: value)),
                ),
              ),
            ),
          ),
        ),
        elevation: 0.0,
        titleSpacing: 0.0,
        title: Text('Livestock'),
      ),
      body: BlocBuilder<SearchAnimalBloc, SearchAnimalState>(
        builder: (BuildContext context, SearchAnimalState state) {
          if (state is ResultsUpdatedState) {
            return ListView.builder(
              itemBuilder: (context, index) =>
                  _buildResultRow(context, state.searchResults[index]),
              itemCount: state.searchResults.length,
            );
          }

          return Container();
        },
      ),
    );
  }

  Widget _buildResultRow(
      BuildContext context, AnimalSearchResult searchResult) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            top: 10.0,
            right: 15.0,
            bottom: 10.0,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(7.0)),
                  color: kAnimalNumberBackgroundColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                    top: 5.0,
                    bottom: 5.0,
                  ),
                  child: Text(
                    searchResult.animalNumber.toString(),
                    style: TextStyle(
                        color: kWhite, fontSize: 22.0, fontFamily: 'Courier'),
                  ),
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Icon(
                Icons.chevron_right,
              )
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
