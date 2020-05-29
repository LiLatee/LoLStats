import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

double roundDouble(double value, int places){
  double mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}

//TODO link zależny od patcha
Image getChampionSplash(String championName) {
  return Image.network(
      "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/${championName}_0.jpg",
      fit: BoxFit.fill);
}

Image getChampionAvatar(String championName) {
  return Image.network(
      "http://ddragon.leagueoflegends.com/cdn/10.10.3216176/img/champion/${championName}.png",
      fit: BoxFit.fill);
}

Image getChampionLoadingSplash(String championName) {
  return Image.network(
      "http://ddragon.leagueoflegends.com/cdn/img/champion/loading/${championName}_0.jpg",
      fit: BoxFit.fill);
}

Image getProfileIcon(String ID) {
  return Image.network(
      "http://ddragon.leagueoflegends.com/cdn/10.11.1/img/profileicon/${ID}.png",
      fit: BoxFit.fill);
}