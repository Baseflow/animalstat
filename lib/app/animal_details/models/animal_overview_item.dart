import 'package:animalstat_repository/animalstat_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

enum AnimalOverviewItemTypes {
  card,
  header,
  subHeader,
}

@immutable
abstract class AnimalOverviewItem extends Equatable {
  const AnimalOverviewItem({
    this.overviewItemType,
  });

  final AnimalOverviewItemTypes overviewItemType;

  @override
  List<Object> get props => [overviewItemType];
}

class AnimalOverviewHeader extends AnimalOverviewItem {
  const AnimalOverviewHeader({
    AnimalOverviewItemTypes overviewItemType,
    this.title,
  })  : assert(overviewItemType == AnimalOverviewItemTypes.header ||
            overviewItemType == AnimalOverviewItemTypes.subHeader),
        super(overviewItemType: overviewItemType);

  final String title;

  @override
  List<Object> get props => super.props..addAll([title]);
}

class AnimalOverviewCard extends AnimalOverviewItem {
  const AnimalOverviewCard({
    this.title,
    this.subtitle,
    this.text,
    this.healthStatus,
  }) : super(overviewItemType: AnimalOverviewItemTypes.card);

  final String title;
  final String subtitle;
  final String text;
  final HealthStates healthStatus;

  @override
  List<Object> get props => super.props
    ..addAll([
      title,
      subtitle,
      text,
      healthStatus,
    ]);
}
