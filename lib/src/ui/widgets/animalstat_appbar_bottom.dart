import 'package:flutter/material.dart';

class AnimalstatAppBarBottom extends StatelessWidget
    implements PreferredSizeWidget {
  static const double _height = 79.0;
  final Widget child;

  const AnimalstatAppBarBottom({@required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration:
          BoxDecoration(color: theme.bottomAppBarTheme.color, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3),
        ),
      ]),
      height: _height,
      width: MediaQuery.of(context).size.width,
      child: DefaultTextStyle(
        style: theme.primaryTextTheme.bodyText2,
        child: child,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(_height);
}
