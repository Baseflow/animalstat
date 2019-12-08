import 'package:livestock_repository/livestock_repository.dart';
import 'package:intl/intl.dart';
class AnimalDetailsViewModel {
  final int animalNumber;
  final String dateOfBirth;
  final HealthStates currentHealthStatus;

  AnimalDetailsViewModel.fromModel(Animal animal)
      : this.animalNumber = animal.animalNumber,
        this.dateOfBirth = DateFormat('dd-MM-yyyy').format(animal.dateOfBirth),
        this.currentHealthStatus = animal.currentHealthStatus;
}
