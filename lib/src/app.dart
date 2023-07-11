import 'package:flutter/material.dart';

import 'home_screen.dart';

class ColorChangeApp extends StatefulWidget {
  const ColorChangeApp({super.key});

  @override
  State<ColorChangeApp> createState() => _ColorChangeAppState();
}

class _ColorChangeAppState extends State<ColorChangeApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
