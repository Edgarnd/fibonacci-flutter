import 'package:flutter/material.dart';

class DatosTemas {
  static ThemeData modoClaro = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: const Color(0xFF007EBB),
    primaryColorDark: const Color(0xFF00227F),
    primaryColorLight: const Color(0xFFF7943A),
    textTheme: const TextTheme(
      bodyText1: TextStyle(fontSize: 16.0),
      bodyText2: TextStyle(fontSize: 16.0),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 3.0,
    )),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            backgroundColor: const Color(0xFF00227F),
            textStyle: const TextStyle(color: Color(0xFF00227F)))),
    brightness: Brightness.light,
  );

  static ThemeData modoOscuro = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: const Color(0xFF007EBB),
    primaryColorDark: const Color(0xFF00227F),
    primaryColorLight: const Color(0xFFF7943A),
    textTheme: const TextTheme(
      bodyText1: TextStyle(fontSize: 16.0),
      bodyText2: TextStyle(fontSize: 16.0),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 3.0,
    )),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            backgroundColor: const Color(0xFF00227F),
            textStyle: const TextStyle(color: Color(0xFF00227F)))),
    brightness: Brightness.dark,
  );
}
