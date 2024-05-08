import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  scaffoldBackgroundColor: Color(0xffb8b5a2),
  fontFamily: 'Montserrat',
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStatePropertyAll(
        Colors.black,
      ),
      textStyle: MaterialStatePropertyAll(
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
      backgroundColor: Color(0xff707d60),
      selectedItemColor: Color(0xffd8d9ce),
      unselectedItemColor: Colors.black),
  cardTheme: CardTheme(
    color: Color.fromARGB(0, 0, 0, 0),
    elevation: 0, 
    
  ),
  
  listTileTheme: ListTileThemeData(tileColor: Colors.transparent)
);
