import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/authentication/bloc/bloc.dart';
import '../theming.dart';

enum MenuOptions {
  help,
  logout,
}

class AnimalstatMenu extends StatelessWidget {
  @override
  Widget build(Object context) {
    return PopupMenuButton<MenuOptions>(
      icon: const Icon(
        Icons.more_vert,
        color: kDefaultTextColor,
      ),
      color: Theme.of(context).dialogBackgroundColor,
      onSelected: (option) => _handleMenuOption(context, option),
      itemBuilder: (context) => <PopupMenuEntry<MenuOptions>>[
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
