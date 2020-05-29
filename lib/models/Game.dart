class Game {
  final int mainRune;
  final int secondRune;

  //TODO dodać summoner spelle
  final int championID;
  final bool isWin;
  final int gameDurationSecs;
  final Map<String, int> KDA;

  Game(
      {this.mainRune,
        this.secondRune,
        this.championID,
        this.isWin,
        this.gameDurationSecs,
        this.KDA});

  factory Game.dummy() {
    return Game(
      mainRune: -1,
      secondRune: -1,
      championID: null,
      isWin: null,
      gameDurationSecs: null,
      KDA: null

    );
  }

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      mainRune: json["base_data"]['perks'][0],
      secondRune: json["base_data"]['perks'][1],
      championID: json['base_data']['championId'],
      isWin: json['base_data']['win'],
      gameDurationSecs: json['base_data']['game_duration'],
      KDA: {
        'kills': json['base_data']['KDA'][0],
        'deaths': json['base_data']['KDA'][1],
        'assists': json['base_data']['KDA'][2]
      },

    );
  }
}