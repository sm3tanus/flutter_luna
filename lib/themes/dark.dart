import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  scaffoldBackgroundColor: Color(0xfff0f0f0),
  fontFamily: 'Montserrat',
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(
        Colors.black,
      ),
      textStyle:WidgetStatePropertyAll (
        TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black,
          fontSize: 16.0,
          fontFamily: 'Montserrat',
        ),
      ),
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xff171717),
      selectedItemColor: Color(0xfff0f0f0),
      unselectedItemColor: Color(0xff565656)),
  cardTheme: CardTheme(
    color: Color.fromARGB(0, 0, 0, 0),
    elevation: 0, 
    
  ),
  
  listTileTheme: ListTileThemeData(tileColor: Colors.transparent)
);
