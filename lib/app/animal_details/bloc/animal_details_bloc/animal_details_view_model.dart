import 'package:flutter/material.dart';
import 'package:livestock_repository/livestock_repository.dart';
import 'package:intl/intl.dart';

class AnimalDetailsViewModel {
  final int animalNumber;
  final String dateOfBirth;
  final HealthStates currentHealthStatus;

  const AnimalDetailsViewModel({
    @required this.animalNumber,
    @required this.dateOfBirth,
    @required this.currentHealthStatus,
  });

  AnimalDetailsViewModel.fromModel(Animal animal)
      : this.animalNumber = animal.animalNumber,
        this.dateOfBirth = DateFormat('dd-MM-yyyy').format(animal.dateOfBirth),
        this.currentHealthStatus = animal.currentHealthStatus;

  AnimalDetailsViewModel copyWith({
    int animalNumber,
    String dateOfBirth,
    HealthStates currentHealthStatus,
  }) {
    return AnimalDetailsViewModel(
      animalNumber: animalNumber ?? this.animalNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      currentHealthStatus: currentHealthStatus ?? this.currentHealthStatus,
    );
  }
}
