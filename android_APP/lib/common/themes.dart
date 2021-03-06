import 'package:flutter/material.dart';

//final baseTheme = ThemeData(
////  primaryColor: Colors.deepPurple,
////  accentColor: Colors.indigoAccent,
//  brightness: Brightness.light,
//  primaryColor: Colors.pink[800],
//  accentColor: Colors.cyan[600],
////  textTheme: TextTheme(
////    display4: TextStyle(
////      fontFamily: 'Corben',
////      fontWeight: FontWeight.w700,
////      fontSize: 24,
////      color: Colors.black,
////    ),
//  );

final baseTheme = ThemeData(
//  scaffoldBackgroundColor: Colors.pink[800],
  scaffoldBackgroundColor: Color(0xff303960),
  brightness: Brightness.light,
//  primaryColor: Color(0xff6c7b95),
//  accentColor: Color(0xff8bbabb),404b80
  primaryColor: Color(0xff404b80),
  accentColor: Colors.cyan[500],
  canvasColor: Color(0xff4d5869),
  textTheme: TextTheme(
    headline2: TextStyle(
      fontSize: 22.0,
      letterSpacing: 3.0,
      color: Colors.white,
    ),
    headline3: TextStyle(
      fontSize: 16.0,
      letterSpacing: 0.0,
      color: Colors.white,
    ),
    headline4: TextStyle(
      fontSize: 12.0,
      letterSpacing: 0.0,
      color: Colors.white,
    ),
  ),
);

// test
final darkTheme = ThemeData(
  primaryColor: Colors.amberAccent,
  accentColor: Colors.blueGrey,
//  textTheme: TextTheme(
//    display4: TextStyle(
//      fontFamily: 'Corben',
//      fontWeight: FontWeight.w700,
//      fontSize: 24,
//      color: Colors.black,
//    ),
);
