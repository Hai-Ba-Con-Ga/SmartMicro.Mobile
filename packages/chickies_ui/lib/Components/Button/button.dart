import 'package:chickies_ui/Colors.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Button',
  type: ChickiesButton,
)
ChickiesButton chickiesButtonUseCase(BuildContext context) {
  return ChickiesButton(onPressed: () {}, text: "Button nef",);
}

class ChickiesButton extends StatefulWidget {
  const ChickiesButton({super.key, required this.onPressed, this.child, this.text, this.backgroundColor, this.textColor, this.width, this.height});

  final Widget? child;
  final String? text;
  final Function() onPressed;
  final Color? backgroundColor, textColor;
  final double? width;
  final double? height;

  @override
  State<ChickiesButton> createState() => ChickiesButtonState();
}

class ChickiesButtonState extends State<ChickiesButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      child: Container(
        margin : const EdgeInsets.symmetric(vertical: 20),
        alignment: Alignment.center,
        width: widget.width ?? double.infinity,
        child: widget.child ?? Text(widget.text?.toUpperCase() ?? 'Button', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.backgroundColor ?? (ChickiesColor.primary ?? Theme.of(context).colorScheme.secondary),
        foregroundColor: widget.textColor ?? (ChickiesColor.secondary ?? Theme.of(context).colorScheme.primary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(45),
        ),
      ),
    );
  }
}
