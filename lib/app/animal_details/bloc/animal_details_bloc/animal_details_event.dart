import 'package:equatable/equatable.dart';
import 'package:flutter/semantics.dart';
import 'package:livestock_repository/livestock_repository.dart';
import 'package:meta/meta.dart';

abstract class AnimalDetailsEvent extends Equatable {
  const AnimalDetailsEvent();
}

class LoadAnimalDetails extends AnimalDetailsEvent {
  final int animalNumber;

  const LoadAnimalDetails({@required this.animalNumber});

  @override
  List<Object> get props => [animalNumber];
}

class AnimalChanged extends AnimalDetailsEvent {
  final Animal animal;

  AnimalChanged({@required this.animal});

  @override
  List<Object> get props => [animal];
}

class UpdateDetails extends AnimalDetailsEvent {
  final int cage;
  final HealthStates currentHealthStatus;
  final DateTime dateOfBirth;

  const UpdateDetails({
    this.cage,
    this.currentHealthStatus,
    this.dateOfBirth,
  });

  @override
  List<Object> get props => [
        cage,
        currentHealthStatus,
        dateOfBirth,
      ];
}
