import 'package:flutter/material.dart';

enum ChickiesColor {
  baseColor('M3 Baseline', Color(0xff6750a4)),
  indigo('Indigo', Colors.indigo),
  blue('Blue', Colors.blue),
  teal('Teal', Colors.teal),
  green('Green', Colors.green),
  yellow('Yellow', Colors.yellow),
  orange('Orange', Colors.orange),
  deepOrange('Deep Orange', Colors.deepOrange),
  pink('Pink', Colors.pink),
  purple('purple', Color(0xFF8083e0)),
  greygreen('purple', Color(0xFFeef2f9)),
  maxChickiesColor('Max Chickies', Color(0xFF8083e0));

  const ChickiesColor(this.label, this.color);
  final String label;
  final Color color;
}