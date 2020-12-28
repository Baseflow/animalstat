import 'package:animalstat/app/authentication/bloc/bloc.dart';
import 'package:animalstat/src/ui/theming.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum MenuOptions {
  help,
  logout,
}

class AnimalstatMenu extends StatelessWidget {
  @override
  Widget build(Object context) {
    return PopupMenuButton<MenuOptions>(
      icon: Icon(
        Icons.more_vert,
        color: kDefaultTextColor,
      ),
      color: Theme.of(context).dialogBackgroundColor,
      onSelected: (option) => _handleMenuOption(context, option),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuOptions>>[
        const PopupMenuItem(
          value: MenuOptions.help,
          child: Text('Help'),
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
        context.read<AuthenticationBloc>().add(LoggedOut());
        break;
    }
  }
}
