import 'package:chickies_ui/Colors.dart';
import 'package:flutter/material.dart';

class RoundedContainer extends Container {
  RoundedContainer({
    super.key,
    super.height,
    super.width,
    super.padding = const EdgeInsets.all(10),
    super.margin = const EdgeInsets.all(20),
    super.child,
    super.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: padding,
        margin: margin,
        constraints: constraints,
        decoration: BoxDecoration(
          color: color ?? ChickiesColor.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: ChickiesColor.shadow,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
            BoxShadow(
              color: color ?? ChickiesColor.white,
              offset: Offset(-5, 0),
            ),
            BoxShadow(
              color: color ?? ChickiesColor.white,
              offset: Offset(5, 0),
            ),
          ],
        ),
        child: child);
  }
}
