import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:livestock/app/animal_details/bloc/animal_details_bloc/animal_details_view_model.dart';
import 'package:livestock_repository/livestock_repository.dart';
import 'package:meta/meta.dart';

class AnimalDetailsState extends Equatable {
  final int animalNumber;
  final AnimalDetailsViewModel animalDetailsViewModel;
  final bool isLoading;

  const AnimalDetailsState(this.animalNumber, {this.animalDetailsViewModel, this.isLoading});

  factory AnimalDetailsState.loading(int animalNumber) {
    return AnimalDetailsState(animalNumber,
      animalDetailsViewModel: null,
      isLoading: true,
    );
  }

  AnimalDetailsState update(Animal animal) {
    var viewModel = AnimalDetailsViewModel.fromModel(animal);

    return copyWith(
      animalDetailsViewModel: viewModel,
      isLoading: false,
    );
  }

  AnimalDetailsState copyWith({
    AnimalDetailsViewModel animalDetailsViewModel,
    bool isLoading,
  }) {
    return AnimalDetailsState(
      this.animalNumber,
      animalDetailsViewModel: animalDetailsViewModel ?? this.animalDetailsViewModel,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [animalNumber, animalDetailsViewModel, isLoading];
}