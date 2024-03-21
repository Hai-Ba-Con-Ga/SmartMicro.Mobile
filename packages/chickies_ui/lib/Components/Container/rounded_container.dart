import 'package:chickies_ui/Colors.dart';
import 'package:flutter/material.dart';

class RoundedContainer extends Container {
  RoundedContainer({
    super.key,
    super.height,
    super.width,
    super.padding = const EdgeInsets.all(100),
    super.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: ChickiesColor.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: ChickiesColor.shadow,
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
            BoxShadow(
              color: ChickiesColor.white,
              offset: Offset(-10, 0),
            ),
            BoxShadow(
              color: ChickiesColor.white,
              offset: Offset(10, 0),
            ),
          ],
        ),
        child: super.build(context));
  }
}
