class KDA {
  int _kills;
  int _deaths;
  int _assists;

  KDA ({int kills, int deaths, int assists})
  {
    this._kills = kills;
    this._deaths = deaths;
    this._assists = assists;
  }

  @override
  String toString() {
    return '$_kills/$_deaths/$_assists';
  }

  int get assists => _assists;

  set assists(int value) {
    _assists = value;
  }

  int get deaths => _deaths;

  set deaths(int value) {
    _deaths = value;
  }

  int get kills => _kills;

  set kills(int value) {
    _kills = value;
  }


}