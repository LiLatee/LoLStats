import 'package:lolstats/models/KDA.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayerGameStats
{
  KDA kda;
  int _goldEarned;
  int _visionScore;
  int _damageDealt;
  int _damageTaken;
  int _damageHealed;
  NetworkImage _champIcon;

  PlayerGameStats(this.kda, this._goldEarned, this._visionScore,
      this._damageDealt, this._damageTaken, this._damageHealed, this._champIcon);

  NetworkImage get champIcon => _champIcon;

  set champIcon(NetworkImage value) {
    _champIcon = value;
  }

  int getAttributeByName(String name) {
    if (name == "_goldEarned" ) { return _goldEarned;}
    else if (name == "_goldEarned" ) { return _goldEarned;}
    else if (name == "_visionScore" ) { return _visionScore;}
    else if (name == "_damageDealt" ) { return _damageDealt;}
    else if (name == "_damageHealed" ) { return _damageHealed;}

    // todo else
  }

  int get damageHealed => _damageHealed;

  set damageHealed(int value) {
    _damageHealed = value;
  }

  int get damageTaken => _damageTaken;

  set damageTaken(int value) {
    _damageTaken = value;
  }

  int get damageDealt => _damageDealt;

  set damageDealt(int value) {
    _damageDealt = value;
  }

  int get visionScore => _visionScore;

  set visionScore(int value) {
    _visionScore = value;
  }

  int get goldEarned => _goldEarned;

  set goldEarned(int value) {
    _goldEarned = value;
  }


}