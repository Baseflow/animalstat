import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livestock/src/ui/theming.dart';
import 'package:livestock/src/ui/widgets/livestock_health_status_label.dart';
import 'package:livestock/app/animal_details/bloc/bloc.dart';

class AnimalDetailsHeader extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(79.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 79.0,
      width: MediaQuery.of(context).size.width,
      color: kAccentColor,
      child: BlocBuilder<AnimalDetailsBloc, AnimalDetailsState>(
          builder: (BuildContext context, AnimalDetailsState state) {
        if (!state.isLoading) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      'Geboortedatum',
                      style: TextStyle(
                        color: kWhite,
                        fontSize: 15.0,
                      ),
                    ),
                    Text(
                      state.animalDetailsViewModel.dateOfBirth,
                      style: TextStyle(
                        color: kWhite,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
                Expanded(child: Container()),
                LivestockHealthStatusLabel(
                    healthStatus: state.animalDetailsViewModel.currentHealthStatus)
              ],
            ),
          );
        } else {
          return PreferredSize(
            preferredSize: Size.zero,
            child: Container(),
          );
        }
      }),
    );
  }
}
