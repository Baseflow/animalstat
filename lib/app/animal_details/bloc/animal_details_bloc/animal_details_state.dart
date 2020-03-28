import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:livestock_repository/livestock_repository.dart';
import 'package:meta/meta.dart';

class AnimalDetailsState extends Equatable {
  final int animalNumber;
  final int cage;
  final HealthStates currentHealthStatus;
  final DateTime dateOfBirth;
  final bool isLoading;

  const AnimalDetailsState({
    @required this.animalNumber,
    @required this.cage,
    @required this.currentHealthStatus,
    @required this.dateOfBirth,
    @required this.isLoading
  });

  String get cageDisplayValue => this.cage?.toString() ?? '-';
  String get dateOfBirthDisplayValue => DateFormat('dd-MM-yyyy').format(dateOfBirth);

  factory AnimalDetailsState.loading(int animalNumber) {
    return AnimalDetailsState(
      animalNumber: animalNumber,
      cage: null,
      currentHealthStatus: null,
      dateOfBirth: null,
      isLoading: true,
    );
  }

  AnimalDetailsState update(Animal animal) {
    return copyWith(
      animalNumber: animal.animalNumber,
      cage: animal.currentCageNumber,
      currentHealthStatus: animal.currentHealthStatus,
      dateOfBirth: animal.dateOfBirth,
      isLoading: false,
    );
  }

  AnimalDetailsState copyWith({
    int animalNumber,
    int cage,
    HealthStates currentHealthStatus,
    DateTime dateOfBirth,
    bool isLoading,
  }) {
    return AnimalDetailsState(
      animalNumber: animalNumber ?? this.animalNumber,
      cage: cage ?? this.cage,
      currentHealthStatus: currentHealthStatus ?? this.currentHealthStatus,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [animalNumber, cage, currentHealthStatus, dateOfBirth, isLoading];
}