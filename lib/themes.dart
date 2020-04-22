
import 'package:flutter/material.dart';

@immutable
class CustomThemes {

  static ThemeData getBaseTheme()
  {
    return ThemeData(
      primaryColor: Colors.deepPurple,
      accentColor: Colors.indigoAccent,
    );
  }
}