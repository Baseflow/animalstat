import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livestock/app/animal/bloc/bloc.dart';
import 'package:livestock/src/ui/theming.dart';
import 'package:livestock/src/ui/widgets/livestock_number_box.dart';

class AnimalDetailsScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(79.0),
          child: Center(
            child: Container(
              height: 79.0,
              width: MediaQuery.of(context).size.width,
              color: kAccentColor,
              child: Container(),
            ),
          ),
        ),
        elevation: 0.0,
        titleSpacing: 0.0,
        title: BlocBuilder<AnimalBloc, AnimalState>(
          builder: (BuildContext context, AnimalState state) {
            if (state is AnimalChanged) {
              return LivestockNumberBox(animalNumber: state.animalId.toString(),);
            }

            return Text('Livestock');
          }
        ),
      ),
      body: Container(),
    );
  }
}