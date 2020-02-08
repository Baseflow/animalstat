import 'package:livestock_repository/livestock_repository.dart';
import 'package:livestock/app/search_animal/bloc/search_animal_bloc.dart';
import 'package:livestock/app/search_animal/search_animals_screen.dart';
import 'package:livestock/app/authentication/bloc/authentication_bloc.dart';
import 'package:livestock/app/authentication/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livestock/src/ui/widgets/livestock_appbar_bottom.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (BuildContext context, AuthenticationState state) {
        var welcomeMessage = 'Welkom';

        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Center(
              child: Text(welcomeMessage),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      brightness: Brightness.dark,
      elevation: 0.0,
      titleSpacing: 0.0,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              FlatButton(
                child: Text(
                  'Uitloggen',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () => BlocProvider.of<AuthenticationBloc>(context)
                    .add(LoggedOut()),
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: Text('Livestock'),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).push(
                SearchAnimalScreen.route(),
              );
            }),
      ],
      bottom: _buildAppBarBottom(),
    );
  }

  PreferredSizeWidget _buildAppBarBottom() {
    return LivestockAppBarBottom(
      child: Container(),
    );
  }
}
