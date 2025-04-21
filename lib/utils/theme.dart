import 'package:flutter/material.dart';
import 'constants.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: PrimaryColor,
    fontFamily: 'EuclidCircularA',
    secondaryHeaderColor: Colors.black,
    hintColor: Colors.orangeAccent,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      // Add more text styles as needed
    ),
    // Add more theme properties as needed
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: Colors.white,
    fontFamily: 'EuclidCircularA',
    secondaryHeaderColor: Colors.white,
    hintColor: Colors.orangeAccent,
    scaffoldBackgroundColor: Colors.black,
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      // Add more text styles as needed
    ),
    // Add more theme properties as needed
  );
}
