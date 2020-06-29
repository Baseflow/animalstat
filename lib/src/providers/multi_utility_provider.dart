import 'package:animalstat/src/providers/utility_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class MultiUtilityProvider extends StatelessWidget {
  /// The [UtilityProvider] list which is converted into a tree of [UtilityProvider] widgets.
  /// The tree of [UtilityProvider] widgets is created in order meaning the first [UtilityProvider]
  /// will be the top-most [UtilityProvider] and the last [UtilityProvider] will be a direct ancestor
  /// of the `child` [Widget].
  final List<UtilityProvider> providers;

  /// The [Widget] and its descendants which will have access to every value provided by `providers`.
  /// This [Widget] will be a direct descendent of the last [UtilityProvider] in `providers`.
  final Widget child;

  /// Merges multiple [UtilityProvider] widgets into one widget tree.
  ///
  /// [MultiUtilityProvider] improves the readability and eliminates the need
  /// to nest multiple [UtilityProviders].
  ///
  /// By using [MultiUtilityProvider] we can go from:
  ///
  /// ```dart
  /// UtilityProvider<UtilityA>(
  ///   builder: (context) => UtilityA(),
  ///   child: UtilityProvider<UtilityB>(
  ///     builder: (context) => UtilityB(),
  ///     child: UtilityProvider<UtilityC>(
  ///       builder: (context) => UtilityC(),
  ///       child: ChildA(),
  ///     )
  ///   )
  /// )
  /// ```
  ///
  /// to:
  ///
  /// ```dart
  /// MultiUtilityProvider(
  ///   providers: [
  ///     UtilityProvider<UtilityA>(builder: (context) => UtilityA()),
  ///     UtilityProvider<UtilityB>(builder: (context) => UtilityB()),
  ///     UtilityProvider<UtilityC>(builder: (context) => UtilityC()),
  ///   ],
  ///   child: ChildA(),
  /// )
  /// ```
  ///
  /// [MultiUtilityProvider] converts the [UtilityProvider] list
  /// into a tree of nested [UtilityProvider] widgets.
  /// As a result, the only advantage of using [MultiUtilityProvider] is improved
  /// readability due to the reduction in nesting and boilerplate.
  const MultiUtilityProvider({
    Key key,
    @required this.providers,
    @required this.child,
  })  : assert(providers != null),
        assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: child,
    );
  }
}
