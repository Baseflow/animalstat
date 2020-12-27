import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animalstat/src/ui/theming.dart';
import 'package:animalstat/src/ui/widgets/animalstat_health_status_label.dart';
import 'package:animalstat/app/animal_details/bloc/bloc.dart';

class AnimalDetailsHeader extends StatelessWidget
    implements PreferredSizeWidget {
  static const double _height = 79.0;

  @override
  Size get preferredSize => Size.fromHeight(_height);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: _height,
      width: MediaQuery.of(context).size.width,
      color: kAccentColor,
      child: DefaultTextStyle(
        style: theme.primaryTextTheme.bodyText2,
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
                          fontSize: 15.0,
                        ),
                      ),
                      Text(
                        state.dateOfBirthDisplayValue,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                          'Hok',
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                        Text(
                          '${state.cageDisplayValue}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  AnimalstatHealthStatusLabel(
                      healthStatus: state.currentHealthStatus)
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
      ),
    );
  }
}
