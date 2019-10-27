import 'package:livestock/app/search_animal/search_animals_screen.dart';
import 'package:livestock/app/authentication/bloc/authentication_bloc.dart';
import 'package:livestock/app/authentication/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  final String name;

  HomeScreen({
    Key key,
    @required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(
            child: Text('Welcome $name'),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context)
  {
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
          IconButton(icon: Icon(Icons.add), onPressed: () {}),
          IconButton(icon: Icon(Icons.search), onPressed: () {
            Navigator.of(context).push(PageRouteBuilder(
              opaque: false,
              pageBuilder: (BuildContext context, _, __) =>
                  SearchAnimalScreen()));
          }),
        ],
      );
  }
}
