import 'package:animal_stat/app/authentication/bloc/authentication_bloc.dart';
import 'package:animal_stat/app/authentication/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        title: Text('Search'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => BlocProvider.of<AuthenticationBloc>(context)
                .dispatch(LoggedOut()),
          ),
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
