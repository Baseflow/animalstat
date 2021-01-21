import 'package:animalstat/app/add_history_record/add_history_record_dialog.dart';
import 'package:animalstat/app/add_history_record/bloc/add_history_record_bloc.dart';
import 'package:animalstat/app/authentication/bloc/authentication_bloc.dart';
import 'package:animalstat/app/authentication/bloc/authentication_state.dart';
import 'package:animalstat_repository/animalstat_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../src/ui/widgets/animalstat_number_box.dart';
import 'bloc/bloc.dart';
import 'models/animal_overview_item.dart';
import 'widgets/history_card.dart';

class AnimalDetailsScreen extends StatelessWidget {
  static MaterialPageRoute route(
    AnimalRepository animalRepository,
    int animalNumber,
  ) {
    return MaterialPageRoute(
      builder: (context) => RepositoryProvider.value(
        value: animalRepository,
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AnimalHistoryBloc>(
              create: (context) => AnimalHistoryBloc(
                animalNumber: animalNumber,
                animalRepository: context.read<AnimalRepository>(),
              )..add(
                  LoadHistory(
                    animalNumber: animalNumber,
                  ),
                ),
            ),
            BlocProvider<AnimalDetailsBloc>(
              create: (context) => AnimalDetailsBloc(
                animalNumber: animalNumber,
                animalRepository: context.read<AnimalRepository>(),
              )..add(
                  LoadDetails(
                    animalNumber: animalNumber,
                  ),
                ),
            ),
          ],
          child: AnimalDetailsScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocBuilder<AnimalHistoryBloc, AnimalHistoryState>(
          builder: (context, state) {
        return CustomScrollView(
          slivers: <Widget>[
            BlocBuilder<AnimalDetailsBloc, AnimalDetailsState>(
              builder: (context, state) {
                if (state.isEmpty || state.isLoading) {
                  return SliverToBoxAdapter(
                    child: Container(),
                  );
                }

                return _buildSliverList(
                  state.overviewItems,
                  titleIcon: Icons.cake,
                );
              },
            ),
            BlocBuilder<AnimalHistoryBloc, AnimalHistoryState>(
                builder: (context, state) {
              if (state.isLoading) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (state.isEmpty) {
                return SliverToBoxAdapter(
                  child: Container(),
                );
              }

              return _buildSliverList(state.overviewItems);
            }),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addDetailButtonPressed(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _addDetailButtonPressed(BuildContext context) {
    final animalRepository = context.read<AnimalRepository>();
    //ignore: close_sinks
    final animalDetailsBloc = context.read<AnimalDetailsBloc>();
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return RepositoryProvider.value(
            value: animalRepository,
            child: MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: animalDetailsBloc,
                ),
                BlocProvider(create: (context) {
                  final authenticatedState =
                      context.read<AuthenticationBloc>().state as Authenticated;

                  return AddHistoryRecordBloc(
                    animalNumber: animalDetailsBloc.state.animalNumber,
                    user: authenticatedState.user,
                    animalRepository: context.read<AnimalRepository>(),
                  );
                }),
              ],
              child: AddHistoryRecordDialog(),
            ),
          );
        });
  }

  static Widget _buildAppBar(BuildContext context) {
    return AppBar(
      brightness: Brightness.dark,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
      titleSpacing: 0.0,
      title: BlocBuilder<AnimalDetailsBloc, AnimalDetailsState>(
          builder: (context, state) {
        return (state is AnimalDetailsState)
            ? AnimalstatNumberBox(
                animalNumber: state.animalNumber.toString(),
              )
            : const Text('animalstat');
      }),
    );
  }

  static SliverList _buildSliverList(List<AnimalOverviewItem> overviewItems,
      {IconData titleIcon = Icons.home}) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final overviewItem = overviewItems[index];

          if (overviewItem is AnimalOverviewHeader) {
            return Padding(
              padding: EdgeInsets.only(
                left: 15.0,
                top: overviewItem.overviewItemType ==
                        AnimalOverviewItemTypes.header
                    ? 15
                    : 10,
                right: 15.0,
                bottom: 10,
              ),
              child: Text(
                overviewItem.title,
                style: TextStyle(
                  fontSize: overviewItem.overviewItemType ==
                          AnimalOverviewItemTypes.header
                      ? 20
                      : 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          return HistoryCard(
            data: overviewItem,
            titleIcon: titleIcon,
          );
        },
        childCount: overviewItems.length,
      ),
    );
  }
}
