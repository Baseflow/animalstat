import 'package:animalstat_repository/animalstat_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animalstat/app/authentication/bloc/bloc.dart';
import 'package:animalstat/app/search_animal/search_animals_screen.dart';
import 'package:animalstat/src/ui/theming.dart';

enum MenuOptions {
  help,
  logout,
  search,
}

class AnimalstatMenu extends StatelessWidget {
  @override
  Widget build(Object context) {
    return PopupMenuButton<MenuOptions>(
      icon: Icon(
        Icons.more_vert,
        color: kDefaultTextColor,
      ),
      color: kPrimaryColor,
      onSelected: (option) => _handleMenuOption(context, option),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuOptions>>[
        const PopupMenuItem(
          value: MenuOptions.help,
          child: Text('Help'),
        ),
        const PopupMenuItem(
          value: MenuOptions.search,
          child: Text('Zoeken'),
        ),
        const PopupMenuItem(
          value: MenuOptions.logout,
          child: Text('Uitloggen'),
        ),
      ],
    );
  }

  void _handleMenuOption(BuildContext context, MenuOptions option) {
    switch (option) {
      case MenuOptions.help:
        break;
      case MenuOptions.logout:
        context.bloc<AuthenticationBloc>().add(LoggedOut());
        break;
      case MenuOptions.search:
        final animalRepository = context.repository<AnimalRepository>();
        Navigator.of(context).push(
          SearchAnimalScreen.route(animalRepository),
        );
        break;
    }
  }
}
