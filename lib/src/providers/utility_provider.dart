import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class UtilityProvider<T> extends Provider<T> {
  /// Takes a [ValueBuilder] that is responsible for
  /// building the utility class and a child which will have access to the utility class via `UtilityProvider.of(context)`.
  /// It is used as a dependency injection (DI) widget so that a single instance of a utility class can be provided
  /// to multiple widgets within a subtree.
  ///
  /// ```dart
  /// UtilityProvider(
  ///   builder: (context) => UtilityA(),
  ///   child: ChildA(),
  /// );
  /// ```
  UtilityProvider({
    Key key,
    @required Create<T> create,
    Widget child,
  }) : super(
          key: key,
          create: create,
          dispose: (_, __) {},
          child: child,
        );

  /// Takes a utility and a child which will have access to the utility.
  /// A new utility should not be created in `UtilityProvider.value`.
  /// Utilities should always be created using the default constructor within the `builder`.
  UtilityProvider.value({
    Key key,
    @required T value,
    Widget child,
  }) : super.value(
          key: key,
          value: value,
          child: child,
        );

  /// Method that allows widgets to access a utility instance as long as their `BuildContext`
  /// contains a [UtilityProvider] instance.
  static T of<T>(BuildContext context) {
    try {
      return Provider.of<T>(context, listen: false);
    } catch (_) {
      throw FlutterError(
        """
        UtilityProvider.of() called with a context that does not contain a utility of type $T.
        No ancestor could be found starting from the context that was passed to UtilityProvider.of<$T>().

        This can happen if:
        1. The context you used comes from a widget above the UtilityProvider.
        2. You used MultiUtilityProvider and didn\'t explicity provide the UtilityProvider types.

        Good: UtilityProvider<$T>(builder: (context) => $T())
        Bad: UtilityProvider(builder: (context) => $T()).

        The context used was: $context
        """,
      );
    }
  }
}
