import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lolstats/common/ConstData.dart' as ConstData;



double roundDouble(double value, int places){
  double mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}

Image getChampionSplash(String championName) {
  return Image.network(
      "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/${championName}_0.jpg",
      fit: BoxFit.fill);
}

Image getChampionAvatar(String championName) {
  return Image.network(
      "http://ddragon.leagueoflegends.com/cdn/${ConstData.newestPatch}/img/champion/$championName.png",
      fit: BoxFit.fill);
}

// todo a tu nie ma zależności od patcha?
Image getChampionLoadingSplash(String championName) {
  return Image.network(
      "http://ddragon.leagueoflegends.com/cdn/img/champion/loading/${championName}_0.jpg",
      fit: BoxFit.fill);
}

Image getProfileIcon(String ID) {
  return Image.network(
      "http://ddragon.leagueoflegends.com/cdn/${ConstData.newestPatch}/img/profileicon/$ID.png",
      fit: BoxFit.fill);
}

Image getItemIcon(int ID) {
  return Image.network(
      "http://ddragon.leagueoflegends.com/cdn/${ConstData.newestPatch}/img/item/$ID.png",
      fit: BoxFit.fill);
}

Image getPerkIcon(int ID) {
  return Image.network(
      ConstData.SERVER_ADDRESS + "get_perk_icon/$ID",
      fit: BoxFit.fill);
}

Image getSummonerSpellIcon(int ID) {
  return Image.network(
      ConstData.SERVER_ADDRESS + "get_s_spell_icon/$ID",
      fit: BoxFit.fill);
}