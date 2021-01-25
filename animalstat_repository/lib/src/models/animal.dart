import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'animal_health_info.dart';

@immutable
class Animal extends Equatable {
  final int animalNumber;
  final DateTime dateOfBirth;
  final int currentCageNumber;
  final AnimalHealthInfo healthInfo;

  Animal(
    this.animalNumber,
    this.dateOfBirth,
    this.currentCageNumber,
    this.healthInfo,
  );

  @override
  List<Object> get props => [
        animalNumber,
        dateOfBirth,
        currentCageNumber,
        healthInfo,
      ];

  @override
  bool get stringify => true;
}
