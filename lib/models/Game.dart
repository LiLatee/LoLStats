
import 'package:flutter/cupertino.dart';
import 'package:lolstats/models/Champion.dart';

class Game {
  Champion _champion;
  bool _isWin;
  Map _KDA;
  int _minutes;
  int _seconds;

  Game(Champion champion, bool isWin, Map KDA, int minutes, int seconds){
    this._champion = champion;
    this._isWin = isWin;
    this._KDA = KDA;
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

  Map get KDA => _KDA;

  set KDA(Map value) {
    _KDA = value;
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