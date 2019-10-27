import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livestock/app/search_animal/bloc/bloc.dart';
import 'package:livestock/app/search_animal/bloc/search_animal_state.dart';
import 'package:livestock/src/ui/theming.dart';
import 'package:livestock/src/ui/widgets/livestock_search_text_field.dart';

import 'bloc/search_animal_bloc.dart';

class SearchAnimalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<SearchAnimalBloc>(context);

    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(79.0),
          child: Center(
            child: Container(
              color: kAccentColor,
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: LivestockSearchTextField(
                  onChanged: (value) => bloc.add(QueryChanged(query: value)),
                ),
              ),
            ),
          ),
        ),
        elevation: 0.0,
        titleSpacing: 0.0,
        title: Text('Livestock'),
      ),
      body: BlocBuilder(
        bloc: bloc,
        builder: (BuildContext context, SearchAnimalState state)
        {
          if (state is ResultsUpdatedState) {
            return ListView.builder(
              itemBuilder: (context, index) => Text(state.searchResults[index].animalNumber.toString()),
              itemCount: state.searchResults.length,);
          }

          return Container();
        },
      ),
    );
  }
}