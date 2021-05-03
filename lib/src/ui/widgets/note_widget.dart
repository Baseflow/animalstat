import 'package:flutter/material.dart';

class NoteWidget extends StatefulWidget {
  NoteWidget({
    this.child,
  });

  final Widget child;

  @override
  _NoteWidgetState createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return _buildExpandableContainer();
  }

  Widget _buildExpandableContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        AnimatedCrossFade(
          alignment: Alignment.topLeft,
          firstChild: Container(
            height: 0.0,
            width: 0.0,
          ),
          secondChild: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: widget.child,
          ),
          firstCurve: Curves.fastOutSlowIn,
          secondCurve: Curves.fastOutSlowIn,
          sizeCurve: Curves.fastOutSlowIn,
          crossFadeState: _isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return GestureDetector(
      onTap: () => setState(() {
        _isExpanded = !_isExpanded;
      }),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            Icons.sticky_note_2_outlined,
            color: Colors.grey[700],
          ),
          const SizedBox(
            width: 8.0,
          ),
          const Expanded(
              child: Text(
            'Notitie',
            textAlign: TextAlign.left,
          )),
          Icon(
            _isExpanded
                ? Icons.keyboard_arrow_up_outlined
                : Icons.keyboard_arrow_down_outlined,
          ),
        ],
      ),
    );
  }
}
