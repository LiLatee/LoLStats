import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lolstats/common/CustomWidgets.dart' as CustomWidgets;
import 'package:lolstats/common/themes.dart';
import 'package:lolstats/models/Game.dart';
import 'package:lolstats/common/AppColors.dart' as AppColors;
import 'package:lolstats/common/AppBars.dart' as AppBars;
import 'package:lolstats/models/PlayerGameStats.dart';
import 'package:lolstats/common/util.dart' as util;
import 'package:lolstats/common/ConstData.dart' as ConstData;
import 'package:lolstats/screens/UserScreen.dart';
import 'package:lolstats/screens/GraphStats.dart';
import 'package:lolstats/common/DeviceSizes.dart' as DeviceSizes;

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

  String dropdownValue = 'Damage Dealt';
  List<int> values;
  List<int> champsIds;
  int currentSummonerChampID;
  List<String> statsList = <String>[
    'Damage Dealt',
    'Damage Taken',
    'Damage Healed',
    'Gold Earned',
    'Vision Score'
  ];

  _GameStatsPlayersTableScreenState({this.game}) {
    champsIds = game.playersData.map<int>((e) => e.championID).toList();

    currentSummonerChampID = game.playersData.indexWhere(
        (e) => e.summonerName.toLowerCase() == game.summonerName.toLowerCase());

    setValuesForGraph(dropdownValue);
  }

  void setValuesForGraph(String chosenStat) {
    if (chosenStat == statsList[0]) {
      values = game.playersData
          .map<int>((e) => e.totalDamageDealtToChampions)
          .toList();
    } else if (chosenStat == statsList[1]) {
      values =
          game.playersData.map<int>((e) => e.totalDamageTaken).toList();
    } else if (chosenStat == statsList[2]) {
      values = game.playersData.map<int>((e) => e.totalHeal).toList();
    } else if (chosenStat == statsList[3]) {
      values = game.playersData.map<int>((e) => e.goldEarned).toList();
    } else if (chosenStat == statsList[4]) {
      values = game.playersData.map<int>((e) => e.visionScore).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    const double CHAMP_AVATAR_SIZE = 18.0;
    const double EDGE_INSECTS_IN_TEAMS_INFO = 8.0;

    Widget createRow({PlayerData player}) {
      Color color =
          player.summonerName.toLowerCase() == game.summonerName.toLowerCase()
              ? Colors.amberAccent
              : Colors.transparent;

      Widget avatarSection = CircleAvatar(
        backgroundColor: color,
        radius: CHAMP_AVATAR_SIZE + 2,
        child: CircleAvatar(
          backgroundImage: util
              .getChampionAvatar(
                  ConstData.championsIdsNames[player.championID.toString()])
              .image,
          radius: CHAMP_AVATAR_SIZE - 2,
        ),
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

      Widget nickAndKdaCsSection = GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Scaffold(
                      appBar: AppBars.baseAppBar(context),
                      body: UserScreen(
                        summonerName: player.summonerName,
                      ),
                    ))),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: EDGE_INSECTS_IN_TEAMS_INFO),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(children: <Widget>[
                Text(
                  player.summonerName,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.0,
                  ),
                ),
              ]),
              Row(
                children: <Widget>[
                  Text(player.kda.toString(),
                      style: TextStyle(
                        fontSize: 12.0,
                      )),
                  Text("\t"),
                  Text(kdaRatio.toString(),
                      style: TextStyle(
                          fontSize: 12.0, fontWeight: FontWeight.bold)),
                  Text("\t"),
                  Text("cs: " + player.totalMinionsKilled.toString(),
                      style: TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
      );

      List<int> itemsID = [
        player.item0,
        player.item1,
        player.item2,
        player.item3,
        player.item4,
        player.item5,
        player.item6,
      ];

      Widget itemsSection = Container(
        padding: EdgeInsets.only(left: EDGE_INSECTS_IN_TEAMS_INFO),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Row(
              children: itemsID
                  .map((itemID) => Container(
                        padding: EdgeInsets.all(1),
                        child: (itemID != 0)
                            ? util.getItemIcon(itemID)
                            : CustomWidgets.getEmtpyItem(context),
                        width: constraints.maxWidth / 7,
                        height: constraints.maxWidth / 7,
                      ))
                  .toList(),
            );
          },
        ),
      );

      return Container(
        height: (CHAMP_AVATAR_SIZE + 5) * 2,
        child: Stack(
          children: <Widget>[
            LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return Opacity(
                opacity: 0.3,
                child: Container(
                  width: DeviceSizes.getWidth(context: context),
                  height: constraints.maxHeight,
                  color: color,
                ),
              );
            }),
            Container(
              color: Colors.transparent,
              padding: EdgeInsets.all(5.0),
              child: Row(
                children: <Widget>[
                  avatarSection,
                  spellsRunesSection,
                  Expanded(flex: 4, child: nickAndKdaCsSection),
                  Expanded(flex: 5, child: itemsSection),
                ],
              ),
            )
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
      child: ListView(
        children: <Widget>[
          blueTeamTable,
          redTeamTable,
        ],
      ),
    );

    // TODO jakis error pojawia się z RenderFlex overflowed
    Widget graphPage = Container(
      margin: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DropdownButton<String>(
            value: dropdownValue,
            icon: Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.white),
            underline: Container(
              height: 2,
              color: baseTheme.accentColor,
            ),
            onChanged: (String newValue) {
              setState(() {
                dropdownValue = newValue;
                setValuesForGraph(newValue);
              });
            },
            items: statsList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          GraphStats(
            values: values,
            champsIds: champsIds,
            currentUserIndex: currentSummonerChampID,
          )
        ],
      ),
    );

    return Scaffold(
      appBar: AppBars.baseAppBar(context),
      body: Container(
        child: DefaultTabController(
          length: 3,
          child: Container(
            child: Column(
              children: <Widget>[
//                BackButton(onPressed: () => Navigator.pop(context),),
                TabBar(
                  tabs: <Widget>[
                    Tab(text: 'Main Table'),
                    Tab(text: 'Table Statistics'),
                    Tab(text: 'Graphs'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: <Widget>[
                      mainTable,
                      GameStatsTableScreen(game: game),
                      graphPage,
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GameStatsTableScreen extends StatefulWidget {
  final Game game;

  GameStatsTableScreen({this.game});

  @override
  _GameStatsTableScreenState createState() => _GameStatsTableScreenState(
      game: game);
}

class _GameStatsTableScreenState extends State<GameStatsTableScreen> {
  final Game game;

  _GameStatsTableScreenState({this.game});

  List<PlayerGameStats> playersList;

  @override
  Widget build(BuildContext context) {
    const double CHAMP_AVATAR_SIZE = 18.0;

    Widget getGameStatsTable() {
      DataCell getDataCell(Widget child, {int index}) {
        return DataCell(
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                    color: index < 5
                        ? AppColors.blueTeamColor
                        : AppColors.redTeamColor,
                    child: Align(
                      child: child,
                      alignment: Alignment.center,
                    )),
              ),
            ],
          ),
        );
      }

      DataColumn getDataColumn(String columnName, {isAvatar = false}) {
        return DataColumn(
            label: Container(
              width: isAvatar ? CHAMP_AVATAR_SIZE * 1.5 : 55,
              child: Text(
                columnName,
                softWrap: true,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            numeric: true);
      }

      Widget gameStatsTable = Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                color: baseTheme.primaryColor,
                child: DataTable(
                  headingRowHeight: 40.0,
                  horizontalMargin: 0.0,
                  columnSpacing: 0.0,
                  columns: [
                    getDataColumn('', isAvatar: true),
                    getDataColumn('Gold Earned'),
                    getDataColumn('Vision Score'),
                    getDataColumn('Damage Dealt'),
                    getDataColumn('Damage Taken'),
                    getDataColumn('Damage Healed'),
                  ],
                  rows: game.playersData
                      .map(
                        (player) => DataRow(
                          cells: [
                            getDataCell(
                                Container(
                                  padding: EdgeInsets.all(5),
                                  child: CircleAvatar(
                                    backgroundColor: player.summonerName
                                                .toLowerCase() ==
                                        game.summonerName.toLowerCase()
                                        ? Colors.amberAccent
                                        : Colors.transparent,
                                    radius: CHAMP_AVATAR_SIZE + 2,
                                    child: CircleAvatar(
                                      backgroundImage: util
                                          .getChampionAvatar(
                                              ConstData.championsIdsNames[
                                                  player.championID.toString()])
                                          .image,
                                      radius: CHAMP_AVATAR_SIZE - 1,
                                    ),
                                  ),
                                ),
                                index: game.playersData.indexOf(player)),
                            getDataCell(
                                Text(player.goldEarned.toString()),
                                index: game.playersData.indexOf(player)),
                            getDataCell(
                                Text(player.visionScore.toString()),
                                index: game.playersData.indexOf(player)),
                            getDataCell(
                                Text(player.totalDamageDealtToChampions
                                    .toString()),
                                index: game.playersData.indexOf(player)),
                            getDataCell(
                                Text(player.totalDamageTaken.toString()),
                                index: game.playersData.indexOf(player)),
                            getDataCell(Text(player.totalHeal.toString()),
                                index: game.playersData.indexOf(player)),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      );
      return gameStatsTable;
    }

    return Container(
      child: ListView(
        children: <Widget>[
          getGameStatsTable(),
        ],
      ),
    );
  }
}
