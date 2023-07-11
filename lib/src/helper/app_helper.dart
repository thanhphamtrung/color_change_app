import 'dart:math';

import 'package:flutter/material.dart';

class AppHelper {
  static Color randomColorGenerator() {
    // Generate random RGB values between 0 and 255
    final random = Random();
    return (Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    ));
  }

  static List<Color> randomColorPaletteGenerator() {
    // Generate random RGB values between 0 and 255
    final random = Random();
    return List.generate(
        5,
        (index) => (Color.fromARGB(
              255,
              random.nextInt(256),
              random.nextInt(256),
              random.nextInt(256),
            )));
  }
}
