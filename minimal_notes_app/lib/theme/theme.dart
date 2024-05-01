import 'package:flutter/material.dart';

/// Light Mode
ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade300,
    primary: Colors.grey.shade200,
    secondary: Colors.amber.shade400,
    inversePrimary: Colors.grey.shade800,
  ),
);

/// Dart Mode
ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade900,
    primary: Colors.grey.shade800,
    secondary: Colors.amber.shade700,
    inversePrimary: Colors.grey.shade300,
  ),
);
