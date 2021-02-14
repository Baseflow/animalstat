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
    this.healthStatus,
    this.note,
    this.text,
    this.title,
    this.subtitle,
  }) : super(overviewItemType: AnimalOverviewItemTypes.card);

  final HealthStates healthStatus;
  final String note;
  final String text;
  final String title;
  final String subtitle;

  @override
  List<Object> get props => super.props
    ..addAll([
      healthStatus,
      note,
      text,
      title,
      subtitle,
    ]);
}
