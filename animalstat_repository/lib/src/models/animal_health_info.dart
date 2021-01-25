import 'package:animalstat_repository/animalstat_repository.dart';
import 'package:equatable/equatable.dart';

import 'package:meta/meta.dart';

@immutable
class AnimalHealthInfo extends Equatable {
  const AnimalHealthInfo({
    this.diagnosis,
    @required this.healthStatus,
    @required this.updatedOn,
  })  : assert(healthStatus != null),
        assert(
          updatedOn != null,
        );

  final HealthStates healthStatus;
  final String diagnosis;
  final DateTime updatedOn;

  @override
  List<Object> get props => [
        diagnosis,
        healthStatus,
        updatedOn,
      ];
}
