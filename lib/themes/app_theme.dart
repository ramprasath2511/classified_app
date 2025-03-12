import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    primaryColor: Colors.green,
    primarySwatch: Colors.green,
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
    ),
    cardColor: Colors.grey[100],
    scaffoldBackgroundColor: Colors.grey[300],
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      bodyMedium: TextStyle(fontSize: 14),
      bodyLarge: TextStyle(fontSize: 16),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.green,
    ),
  );

  static final darkTheme = ThemeData(
    primaryColor: Colors.black,
    primarySwatch: Colors.green,
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
    cardColor: Colors.grey[900],
    scaffoldBackgroundColor: Colors.grey[750],
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      bodyMedium: TextStyle(fontSize: 16),
      bodyLarge: TextStyle(fontSize: 16),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.green,
    ),
  );
}
