import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:livestock/app/animal/bloc/bloc.dart';
import 'package:livestock/app/animal/widgets/registration_card.dart';
import 'package:livestock/app/animal/widgets/registration_header.dart';
import 'package:livestock/src/ui/theming.dart';
import 'package:livestock/src/ui/widgets/livestock_appbar_bottom.dart';
import 'package:livestock/src/ui/widgets/livestock_health_status_label.dart';
import 'package:livestock/src/ui/widgets/livestock_number_box.dart';

class AnimalDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: RegistrationHeader(),
          ),
          BlocBuilder<AnimalBloc, AnimalState>(
            builder: (BuildContext context, AnimalState state) {
              if(state is HistoryUpdated) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                    return RegistrationCard(historyRecord: state.history[index],);
                  },
                    childCount: state.history.length,
                  ),
                );
              } else {
                return SliverToBoxAdapter(child: Container());
              }
            }
          ),
        ],
      ),
    );
  }

  static Widget _buildAppBar(BuildContext context) {
    return AppBar(
      brightness: Brightness.dark,
      bottom: _buildAppBarBottom(context),
      elevation: 0.0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
      titleSpacing: 0.0,
      title: BlocBuilder<AnimalBloc, AnimalState>(
          builder: (BuildContext context, AnimalState state) {
        return (state is AnimalChanged)
            ? LivestockNumberBox(
                animalNumber: state.animalNumber.toString(),
              )
            : Text('Livestock');
      }),
    );
  }

  static PreferredSizeWidget _buildAppBarBottom(BuildContext context) {
    return LivestockAppBarBottom(
      child: BlocBuilder<AnimalBloc, AnimalState>(
          builder: (BuildContext context, AnimalState state) {
        if (state is HistoryUpdated) {
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
                      DateFormat('dd-MM-yyyy').format(state.animal.dateOfBirth),
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
                    healthStatus: state.animal.currentHealthStatus)
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
