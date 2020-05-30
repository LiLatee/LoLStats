class User {
  final int profileIconId;
  final String accountID;
  final String name;
  final int summonerLevel;
  final List<QueueData> queuesData;

  User(
      {this.profileIconId,
      this.accountID,
      this.name,
      this.summonerLevel,
      this.queuesData});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        profileIconId: json['profileIconId'],
        accountID: json['accountID'],
        name: json['name'],
        summonerLevel: json['summonerLevel'],
        queuesData: json['ranked_data']
            .map<QueueData>((queueJson) => QueueData.fromJson(queueJson))
            .toList());
  }
}

class QueueData {
  final String leagueId;
  final String queueType;
  final String tier;
  final String rank;
  final String summonerId;
  final String summonerName;
  final int leaguePoints;
  final int wins;
  final int losses;
  final bool veteran;
  final bool inactive;
  final bool freshBlood;
  final bool hotStreak;

  QueueData(
      {this.leagueId,
      this.queueType,
      this.tier,
      this.rank,
      this.summonerId,
      this.summonerName,
      this.leaguePoints,
      this.wins,
      this.losses,
      this.veteran,
      this.inactive,
      this.freshBlood,
      this.hotStreak});

  factory QueueData.fromJson(Map<String, dynamic> json) {
    return QueueData(
        leagueId: json["leagueId"],
        queueType: json["queueType"],
        tier: json["tier"],
        rank: json["rank"],
        summonerId: json["summonerId"],
        summonerName: json["summonerName"],
        leaguePoints: json["leaguePoints"],
        wins: json["wins"],
        losses: json["losses"],
        veteran: json["veteran"],
        inactive: json["inactive"],
        freshBlood: json["freshBlood"],
        hotStreak: json["hotStreak"]);
  }
}

