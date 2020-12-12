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
      height: _height,
      width: MediaQuery.of(context).size.width,
      color: theme.bottomAppBarTheme.color,
      child: DefaultTextStyle(
        style: theme.primaryTextTheme.bodyText2,
        child: child,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_height);
}
