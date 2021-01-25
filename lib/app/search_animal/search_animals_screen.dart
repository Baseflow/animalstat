import 'package:animalstat_repository/animalstat_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../src/ui/widgets/animalstat_card.dart';
import '../../src/ui/widgets/animalstat_health_status_label.dart';
import '../../src/ui/widgets/animalstat_number_box.dart';
import '../animal_details/animal_details_screen.dart';
import 'bloc/bloc.dart';

class SearchAnimalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchAnimalBloc, SearchAnimalState>(
      builder: (context, state) {
        if (state.isSearching) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.notFound) {
          return _buildMessage(
            context,
            'Geen resultaten gevonden.',
          );
        }

        if (state.isEmpty) {
          return _buildMessage(
            context,
            'Vul een diernummer in om een dier te zoeken.',
          );
        }

        if (state.isInvalidQuery) {
          return _buildMessage(
            context,
            'Het ingevoerde nummer "${state.query}" bevat illegale characters.',
          );
        }

        return ListView.builder(
          itemBuilder: (context, index) =>
              _buildResultRow(context, state.searchResults[index]),
          itemCount: state.searchResults.length,
          padding: const EdgeInsets.all(8.0),
        );
      },
    );
  }

  Widget _buildMessage(BuildContext context, String message) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Text(
          message,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 16.0,
          ),
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildResultRow(BuildContext context, Animal searchResult) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        var animalRepository = context.read<AnimalRepository>();
        Navigator.of(context).push(
          AnimalDetailsScreen.route(
            animalRepository,
            searchResult.animalNumber,
          ),
        );
      },
      child: AnimalStatCard(
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            top: 15.0,
            right: 15.0,
            bottom: 15.0,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AnimalstatNumberBox(
                animalNumber: searchResult.animalNumber.toString(),
              ),
              Expanded(
                child: Container(),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: AnimalstatHealthStatusLabel(
                  healthStatus: searchResult.healthInfo?.healthStatus ??
                      HealthStates.unknown,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
