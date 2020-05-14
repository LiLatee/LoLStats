
import 'package:flutter/cupertino.dart';
import 'package:lolstats/models/Champion.dart';
import 'package:lolstats/models/KDA.dart';

class Game {
  Champion _champion;
  bool _isWin;
  KDA _kda;
  int _minutes;
  int _seconds;

  Game(Champion champion, bool isWin, KDA kda, int minutes, int seconds){
    this._champion = champion;
    this._isWin = isWin;
    this._kda = kda;
    this._minutes = minutes;
    this._seconds = seconds;
  }

  int get seconds => _seconds;

  set seconds(int value) {
    _seconds = value;
  }

  int get minutes => _minutes;

  set minutes(int value) {
    _minutes = value;
  }

  KDA get kda => _kda;

  set kda(KDA kda){
    _kda = kda;
  }

  bool get isWin => _isWin;

  set isWin(bool value) {
    _isWin = value;
  }

  Champion get champion => _champion;

  set champion(Champion value) {
    _champion = value;
  }


}