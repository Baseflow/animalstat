import 'package:flutter/material.dart';

class AnimalstatToggleButton extends StatelessWidget {
  AnimalstatToggleButton({
    @required this.children,
    @required this.selectedChildren,
    this.onPressed,
    this.selectedIndex,
  });

  final List<Widget> children;
  final void Function(int index) onPressed;
  final List<Widget> selectedChildren;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 15,
      spacing: 15,
      children: List<Widget>.generate(children.length, (index) {
        return _ToggleButton(
          child: index == selectedIndex
              ? selectedChildren[index]
              : children[index],
          onPressed: onPressed != null ? () => onPressed(index) : null,
        );
      }),
    );
  }
}

class _ToggleButton extends StatelessWidget {
  _ToggleButton({
    @required this.child,
    this.onPressed,
  });

  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: child,
      onTap: onPressed,
    );
  }
}
