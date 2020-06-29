import 'package:flutter/material.dart';
import 'package:animalstat_repository/animalstat_repository.dart';
import 'package:intl/intl.dart';

class AnimalDetailsViewModel {
  final int animalNumber;
  final int cage;
  final HealthStates currentHealthStatus;
  final String dateOfBirth;

  const AnimalDetailsViewModel({
    @required this.animalNumber,
    @required this.cage,
    @required this.currentHealthStatus,
    @required this.dateOfBirth,
  });

  AnimalDetailsViewModel.fromModel(Animal animal)
      : this.animalNumber = animal.animalNumber,
        this.cage = animal.currentCageNumber,
        this.currentHealthStatus = animal.currentHealthStatus,
        this.dateOfBirth = DateFormat('dd-MM-yyyy').format(animal.dateOfBirth);

  AnimalDetailsViewModel copyWith({
    int animalNumber,
    int cage,
    HealthStates currentHealthStatus,
    String dateOfBirth,
  }) {
    return AnimalDetailsViewModel(
      animalNumber: animalNumber ?? this.animalNumber,
      cage: cage ?? this.cage,
      currentHealthStatus: currentHealthStatus ?? this.currentHealthStatus,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    );
  }
}
