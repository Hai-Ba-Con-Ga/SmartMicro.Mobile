import 'package:chickies_ui/Colors.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Button',
  type: ChickiesButton,
)
ChickiesButton chickiesButtonUseCase(BuildContext context) {
  return ChickiesButton(
    onPressed: () {},
    text: "Button nef",
  );
}

class ChickiesButton extends StatefulWidget {
  const ChickiesButton({super.key, required this.onPressed, this.child, this.text, this.backgroundColor, this.textColor, this.width, this.height, this.padding, this.reversedColor = false});

  final Widget? child;
  final String? text;
  final Function() onPressed;
  final Color? backgroundColor, textColor;
  final double? width;
  final double? height;
  final reversedColor;
  final EdgeInsetsGeometry? padding;

  @override
  State<ChickiesButton> createState() => ChickiesButtonState();
}

class ChickiesButtonState extends State<ChickiesButton> {
  @override
  Widget build(BuildContext context) {
    final backgroundColor = widget.backgroundColor ?? (ChickiesColor.primary);
    final foregroundColor = widget.textColor ?? (ChickiesColor.secondary);

    return Container(
      height: widget.height ?? null,
      padding: widget.padding ?? null,
      child: IntrinsicHeight(
        child: ElevatedButton(
          onPressed: widget.onPressed,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            alignment: Alignment.center,
            width: widget.width ?? double.infinity,
            child: widget.child ?? Text(widget.text?.toUpperCase() ?? 'Button', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: widget.reversedColor ? foregroundColor : backgroundColor,
            foregroundColor: widget.reversedColor ? backgroundColor : foregroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(45),
            ),
          ),
        ),
      ),
    );
  }
}
