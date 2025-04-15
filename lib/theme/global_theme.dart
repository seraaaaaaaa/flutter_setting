import 'package:flutter/material.dart';

class GlobalTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),
    textTheme: TextTheme(
      headlineSmall: boldTextStyle,
      headlineMedium: boldTextStyle,
      headlineLarge: boldTextStyle,
      titleLarge: semiboldTextStyle,
      titleMedium: semiboldTextStyle,
      titleSmall: semiboldTextStyle.copyWith(color: Colors.grey.shade800),
      labelLarge: labelTextStyle.copyWith(fontSize: 15),
      labelMedium: labelTextStyle,
      labelSmall: labelTextStyle,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
    textTheme: TextTheme(
      headlineSmall: boldTextStyle,
      headlineMedium: boldTextStyle,
      headlineLarge: boldTextStyle,
      titleLarge: semiboldTextStyle,
      titleMedium: semiboldTextStyle,
      titleSmall: semiboldTextStyle.copyWith(color: Colors.grey.shade800),
      labelLarge: labelTextStyle.copyWith(fontSize: 15),
      labelMedium: labelTextStyle,
      labelSmall: labelTextStyle,
    ),
  );

  static const TextStyle boldTextStyle = TextStyle(
    fontWeight: FontWeight.w600,
    letterSpacing: .6,
  );

  static const TextStyle semiboldTextStyle = TextStyle(
    fontWeight: FontWeight.w500,
    letterSpacing: .6,
  );

  static const TextStyle labelTextStyle = TextStyle(
    letterSpacing: .6,
  );
}
