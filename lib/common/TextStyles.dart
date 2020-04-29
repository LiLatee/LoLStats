
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

TextStyle gameResult = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
TextStyle nickname =  TextStyle(
  shadows: [
    Shadow(
      // bottomLeft
        offset: Offset(-1, -1),
        color: Colors.white),
    Shadow(
      // bottomRight
        offset: Offset(1, -1),
        color: Colors.white),
    Shadow(
      // topRight
        offset: Offset(1, 1),
        color: Colors.white),
    Shadow(
      // topLeft
        offset: Offset(-1, 1),
        color: Colors.white),
  ],
  fontSize: 25,
  fontWeight: FontWeight.bold,
);
TextStyle queueType = TextStyle(
  fontWeight: FontWeight.bold,
  color: Colors.black,
  fontSize: 15,
);
