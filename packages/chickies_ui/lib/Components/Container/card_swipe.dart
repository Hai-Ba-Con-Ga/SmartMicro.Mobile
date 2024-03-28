import 'package:flutter/material.dart';

import '../../chickies_ui.dart';

class CardSwipe extends StatefulWidget {
  const CardSwipe({super.key, required this.child, required this.onPressed, this.height = 80, this.width = 100});

  final Function onPressed;
  final double height;
  final double width;
  final Widget child;

  @override
  State<CardSwipe> createState() => _CardSwipeState();
}

class _CardSwipeState extends State<CardSwipe> {
  double _position = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      child: Stack(
        children: [
          Positioned(
            left: _position,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                final next = _position + details.delta.dx;
                if (-widget.width <= next && next <= 0) {
                  setState(() => _position += details.delta.dx);
                }
              },
              onHorizontalDragEnd: (details) {
                if (_position < -(widget.width / 2)) {
                  setState(() => _position = -widget.width);
                } else {
                  setState(() => _position = 0);
                }
              },
              child: widget.child,
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width + _position,
            bottom: 5,
            top: 5,
            child: RoundedContainer(
              color: ChickiesColor.red,
              child: IntrinsicWidth(child: IconButton(onPressed: widget.onPressed as void Function()?, icon: Icon(Icons.delete_outline_rounded, color: ChickiesColor.white))),
              padding: const EdgeInsets.all(0),
              margin: const EdgeInsets.all(10),
            ),
          ),
        ],
      ),
    );
  }
}