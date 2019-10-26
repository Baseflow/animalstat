import 'package:livestock/app/authentication/bloc/authentication_bloc.dart';
import 'package:livestock/app/authentication/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livestock/src/ui/theming.dart';
import 'package:livestock/src/ui/widgets/livestock_text_field.dart';

class SearchAnimalScreen extends StatelessWidget {
  final String name;

  SearchAnimalScreen({
    Key key,
    @required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
      ),
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
}