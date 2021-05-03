import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'animal_health_info.dart';

@immutable
class Animal extends Equatable {
  final int animalNumber;
  final DateTime dateOfBirth;
  final int currentCageNumber;
  final AnimalHealthInfo healthInfo;
  final String note;

  Animal(
    this.animalNumber,
    this.dateOfBirth,
    this.currentCageNumber,
    this.healthInfo,
    this.note,
  );

  @override
  List<Object> get props => [
        animalNumber,
        dateOfBirth,
        currentCageNumber,
        healthInfo,
        note,
      ];

  @override
  bool get stringify => true;
}
