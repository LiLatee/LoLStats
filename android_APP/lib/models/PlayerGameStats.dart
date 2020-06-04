import 'package:lolstats/models/KDA.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayerGameStats {
  int championID;
  KDA kda;
  int goldEarned;
  int visionScore;
  int damageDealt;
  int damageTaken;
  int damageHealed;
  NetworkImage champIcon;
  bool isWin;

  PlayerGameStats({
    this.championID,
    this.kda,
    this.goldEarned,
    this.visionScore,
    this.damageDealt,
    this.damageTaken,
    this.damageHealed,
    this.champIcon,
    this.isWin,
  });

  int getAttributeByName(String name) {
    if (name == "_goldEarned") {
      return goldEarned;
    } else if (name == "_goldEarned") {
      return goldEarned;
    } else if (name == "_visionScore") {
      return visionScore;
    } else if (name == "_damageDealt") {
      return damageDealt;
    } else if (name == "_damageHealed") {
      return damageHealed;
    }

    // todo else
  }
}
