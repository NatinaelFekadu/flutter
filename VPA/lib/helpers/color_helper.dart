import 'package:flutter/material.dart';

class ColorHelper {
  static Color parseColor(String hexColor) {
    try {
      if (hexColor.isNotEmpty && hexColor.length == 7 && hexColor[0] == '#') {
        return Color(
            int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000);
      }
    } catch (e) {
      print('Error parsing color: $e');
    }
    return Colors.white; // Default color
  }
}
