import 'package:animalstat/src/ui/theming.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// A animal stat design card: a panel with slightly rounded corners.
///
/// A card is a sheet used to represent some related information,
/// for example an album, a geographical location a meal, contact details, etc.
///
/// This is what it looks like when run:
///
/// This sample shows creation of a [Card] widget that shows album information
/// and two actions.
///
/// ```dart
/// Widget build(BuildContext context) {
///   return Center(
///     child: AnimalStatCard(
///       child: Column(
///         mainAxisSize: MainAxisSize.min,
///         children: <Widget>[
///           const ListTile(
///             leading: Icon(Icons.album),
///             title: Text('The Enchanted Nightingale'),
///             subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
///           ),
///           Row(
///             mainAxisAlignment: MainAxisAlignment.end,
///             children: <Widget>[
///               TextButton(
///                 child: const Text('BUY TICKETS'),
///                 onPressed: () { /* ... */ },
///               ),
///               const SizedBox(width: 8),
///               TextButton(
///                 child: const Text('LISTEN'),
///                 onPressed: () { /* ... */ },
///               ),
///               const SizedBox(width: 8),
///             ],
///           ),
///         ],
///       ),
///     ),
///   );
/// }
/// ```
/// {@end-tool}
///
/// Sometimes the primary action area of a card is the card itself. Cards can be
/// one large touch target that shows a detail screen when tapped.
///
/// {@tool dartpad --template=stateless_widget_scaffold}
///
/// This sample shows creation of a [Card] widget that can be tapped. When
/// tapped this [Card]'s [InkWell] displays an "ink splash" that fills the
/// entire card.
///
/// ```dart
/// Widget build(BuildContext context) {
///   return Center(
///     child: AnimalStatCard(
///       child: InkWell(
///         splashColor: Colors.blue.withAlpha(30),
///         onTap: () {
///           print('Card tapped.');
///         },
///         child: Container(
///           width: 300,
///           height: 100,
///           child: Text('A card that can be tapped'),
///         ),
///       ),
///     ),
///   );
/// }
/// ```
///
/// {@end-tool}
///
class AnimalStatCard extends StatelessWidget {
  /// Creates a material design card.
  const AnimalStatCard({
    Key key,
    this.color,
    this.margin,
    this.clipBehavior,
    this.child,
    this.semanticContainer = true,
  }) : super(key: key);

  /// The card's background color.
  ///
  /// Defines the card's [Material.color].
  ///
  /// If this property is null then [CardTheme.color] of [ThemeData.cardTheme]
  /// is used. If that's null then [ThemeData.cardColor] is used.
  final Color color;

  /// {@macro flutter.widgets.Clip}
  ///
  /// If this property is null then [CardTheme.clipBehavior] of
  /// [ThemeData.cardTheme] is used. If that's null then the behavior will be [Clip.none].
  final Clip clipBehavior;

  /// The empty space that surrounds the card.
  ///
  /// Defines the card's outer [Container.margin].
  ///
  /// If this property is null then [CardTheme.margin] of
  /// [ThemeData.cardTheme] is used. If that's null, the default margin is 4.0
  /// logical pixels on all sides: `EdgeInsets.all(4.0)`.
  final EdgeInsetsGeometry margin;

  /// Whether this widget represents a single semantic container, or if false
  /// a collection of individual semantic nodes.
  ///
  /// Defaults to true.
  ///
  /// Setting this flag to true will attempt to merge all child semantics into
  /// this node. Setting this flag to false will force all child semantic nodes
  /// to be explicit.
  ///
  /// This flag should be false if the card contains multiple different types
  /// of content.
  final bool semanticContainer;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.child}
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final CardTheme cardTheme = CardTheme.of(context);

    return Semantics(
      container: semanticContainer,
      child: Container(
        margin: margin ?? cardTheme.margin ?? const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          border: Border.all(color: color ?? kBorderColor),
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        child: Material(
          type: MaterialType.card,
          color: color ?? cardTheme.color ?? theme.cardColor,
          shape: cardTheme.shape ??
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
          clipBehavior: clipBehavior ?? cardTheme.clipBehavior ?? Clip.none,
          child: Semantics(
            explicitChildNodes: !semanticContainer,
            child: child,
          ),
        ),
      ),
    );
  }
}
