import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lolstats/common/CustomWidgets.dart' as CustomWidgets;
import 'package:lolstats/common/themes.dart';
import 'package:lolstats/models/Game.dart';
import 'package:lolstats/models/KDA.dart';
import 'package:lolstats/common/AppColors.dart' as AppColors;
import 'package:lolstats/common/AppBars.dart' as AppBars;
import 'package:lolstats/models/PlayerGameStats.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:lolstats/screens/GameStatsTableScreen.dart';
import 'package:lolstats/common/util.dart' as util;
import 'package:lolstats/common/CustomWidgets.dart' as CustomWidgets;
import 'package:lolstats/common/ConstData.dart' as ConstData;

class GameStatsPlayersTableScreen extends StatefulWidget {
  final Game game;

  GameStatsPlayersTableScreen({this.game});

  @override
  _GameStatsPlayersTableScreenState createState() =>
      _GameStatsPlayersTableScreenState(game: this.game);
}

class _GameStatsPlayersTableScreenState
    extends State<GameStatsPlayersTableScreen> {
  final Game game;

  _GameStatsPlayersTableScreenState({this.game});

  List<PlayerGameStats> playersList;
  NetworkImage asheIcon;

  @override
  void initState() {
    asheIcon = NetworkImage(
        'https://gamepedia.cursecdn.com/lolesports_gamepedia_en/4/4a/AsheSquare.png');
    playersList = game.playersData
        .map(
          (e) => PlayerGameStats(
              kda: e.kda,
              damageDealt: e.stats.totalDamageDealtToChampions,
              isWin: true,
              champIcon: asheIcon,
              damageHealed: e.stats.totalHeal,
              damageTaken: e.stats.totalDamageTaken,
              goldEarned: e.stats.goldEarned,
              visionScore: e.stats.visionScore),
        )
        .toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const double CHAMP_AVATAR_SIZE = 18.0;
    const double EDGE_INSECTS_IN_TEAMS_INFO = 8.0;



    Widget createRow({PlayerData player}) {
      Widget avatarSection = CircleAvatar(
        backgroundImage: util.getChampionAvatar(ConstData.championsIdsNames["33"]).image, // TODO
        radius: CHAMP_AVATAR_SIZE,
      );

      Widget spellsRunesSection = Container(
          padding: EdgeInsets.only(left: 8.0),
          child: Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: CHAMP_AVATAR_SIZE,
                    width: CHAMP_AVATAR_SIZE,
                    child: Image.network(
                        'https://vignette.wikia.nocookie.net/leagueoflegends/images/7/74/Flash.png/revision/latest?cb=20180514003149'),
                  ),
                  Container(
                    height: CHAMP_AVATAR_SIZE,
                    width: CHAMP_AVATAR_SIZE,
                    child: Image.network(
                        'https://vignette.wikia.nocookie.net/leagueoflegends/images/f/f4/Ignite.png/revision/latest?cb=20180514003345'),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: CHAMP_AVATAR_SIZE / 2,
                    child: Image.network(
                        'https://vignette.wikia.nocookie.net/leagueoflegends/images/f/f2/Lethal_Tempo_rune.png/revision/latest/scale-to-width-down/64?cb=20171126182145'),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: CHAMP_AVATAR_SIZE / 2,
                    child: Image.network(
                        'https://vignette.wikia.nocookie.net/leagueoflegends/images/1/1e/Domination_icon.png/revision/latest/scale-to-width-down/28?cb=20170926031123'),
                  ),
                ],
              ),
            ],
          ));

      String kdaRatio = player.kda.deaths > 0
          ? util
              .roundDouble(
                  (player.kda.kills + player.kda.assists) / player.kda.deaths,
                  2)
              .toString()
          : util
              .roundDouble(((player.kda.kills + player.kda.assists) / 1), 2)
              .toString();

      Widget nickAndKdaCsSection = Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: EDGE_INSECTS_IN_TEAMS_INFO),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget> [Text(
                player.summonerName,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 12.0,
                ),
              ),]
            ),
            Row(
              children: <Widget>[
                Text(player.kda.toString(), style: TextStyle(fontSize: 12.0,)),
                Text("\t"),
                Text(kdaRatio.toString(), style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold)),
                Text("\t"),
                Text("cs: " + player.stats.totalMinionsKilled.toString(), style: TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
      );

      List<int> itemsID = [
        player.stats.item0,
        player.stats.item1,
        player.stats.item2,
        player.stats.item3,
        player.stats.item4,
        player.stats.item5,
        player.stats.item6,
      ];

      Widget itemsSection = Container(
        padding: EdgeInsets.only(left: EDGE_INSECTS_IN_TEAMS_INFO),
        child: Row(
          children: itemsID
              .map((itemID) => Container(
            padding: EdgeInsets.all(1),
                    child: (itemID != 0) ? util.getItemIcon(itemID) : CustomWidgets.getEmtpyItem(context),
                    width: CHAMP_AVATAR_SIZE * 1.25,
                    height: CHAMP_AVATAR_SIZE * 1.25,
                  ))
              .toList(),
        ),
      );

      return Container(
        padding: EdgeInsets.all(5.0),
        child: Row(
          children: <Widget>[
            avatarSection,
            spellsRunesSection,
            Expanded(flex: 4, child: nickAndKdaCsSection),
            Expanded(flex: 5, child: itemsSection),
          ],
        ),
      );
    }

    Widget blueTeamTable = Container(
      color: AppColors.blueTeamColor,
      child: Column(
        children: game.playersData
            .sublist(0, 5)
            .map<Widget>((e) => createRow(player: e))
            .toList(),
      ),
    );
    Widget redTeamTable = Container(
      color: AppColors.redTeamColor,
      child: Column(
        children: game.playersData
            .sublist(5, 10)
            .map<Widget>((e) => createRow(player: e))
            .toList(),
      ),
    );

    Widget mainTable = Container(
      color: baseTheme.primaryColor,
      child: ListView(
        children: <Widget>[
          redTeamTable,
          blueTeamTable,
        ],
      ),
    );

    return Scaffold(
      appBar: AppBars.baseAppBar(context),
      body: Container(
        child: DefaultTabController(
          length: 2,
          child: Container(
            color: baseTheme.primaryColor,
            child: Column(
              children: <Widget>[
//                BackButton(onPressed: () => Navigator.pop(context),),
                TabBar(
                  labelColor: baseTheme.accentColor,
                  tabs: <Widget>[
                    Tab(text: 'Main Table'),
                    Tab(text: 'Table Statistics'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: <Widget>[
                      mainTable,
                      GameStatsTableScreen(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBars.baseAppBar(context),
      body: Container(
        color: baseTheme.primaryColor,
        child: ListView(
          children: <Widget>[
            CustomWidgets.getNewSectionText(context, "Player Statistics"),
            redTeamTable,
            blueTeamTable,
          ],
        ),
      ),
    );
  }
}
