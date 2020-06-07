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
import 'dart:math';

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
      values = game.playersData.map<int>((e) => e.totalDamageTaken).toList();
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
    final double ROW_HEIGHT = 40 * DeviceSizes.getScaleFactor(context: context);
    final double PADDING_BETWEEN_ROWS =
        3 * DeviceSizes.getScaleFactor(context: context);

    Widget createRow({PlayerData player}) {
      Color color =
          player.summonerName.toLowerCase() == game.summonerName.toLowerCase()
              ? Colors.amberAccent
              : Colors.transparent;

      Widget avatarSection = CircleAvatar(
        backgroundColor: color,
        radius: ROW_HEIGHT / 2,
        child: CircleAvatar(
          backgroundImage: util
              .getChampionAvatar(
                  ConstData.championsIdsNames[player.championID.toString()])
              .image,
          radius: (ROW_HEIGHT / 2) * 0.9,
        ),
      );

      Widget spellsRunesSection = Container(
          padding: EdgeInsets.only(left: 5.0),
          child: Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 1.0, right: 1.0),
                    height: ROW_HEIGHT / 2,
                    width: ROW_HEIGHT / 2,
                    child:
                        util.getSummonerSpellIcon(player.firstSummonerSpellID),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 1.0, right: 1.0),
                    height: ROW_HEIGHT / 2,
                    width: ROW_HEIGHT / 2,
                    child:
                        util.getSummonerSpellIcon(player.secondSummonerSpellID),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
//                    padding: EdgeInsets.only(bottom: 1.0, left: 1.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      maxRadius: ROW_HEIGHT / 4,
                      backgroundImage: util.getPerkIcon(player.perk0).image,
                    ),
                  ),
                  Container(
//                    padding: EdgeInsets.only(top: 1.0, left: 1.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      maxRadius: ROW_HEIGHT / 4,
                      backgroundImage: util.getChampionAvatar('Zed').image,
                    ),
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
          padding: EdgeInsets.only(left: 5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(children: <Widget>[
                Text(
                  player.summonerName,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize:
                        14.0 * DeviceSizes.getScaleFactor(context: context),
                  ),
                ),
              ]),
              Row(
                children: <Widget>[
                  Text(player.kda.toString(),
                      style: TextStyle(
                        fontSize:
                            12.0 * DeviceSizes.getScaleFactor(context: context),
                      )),
                  Text("\t"),
                  Text(kdaRatio.toString(),
                      style: TextStyle(
                          fontSize: 12.0 *
                              DeviceSizes.getScaleFactor(context: context),
                          fontWeight: FontWeight.bold)),
                  Text("\t"),
                  Text("cs: " + player.totalMinionsKilled.toString(),
                      style: TextStyle(
                          fontSize: 12.0 *
                              DeviceSizes.getScaleFactor(context: context))),
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
        padding: EdgeInsets.only(left: 1.0),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Row(
              children: itemsID
                  .map((itemID) => Container(
                        padding: EdgeInsets.all(1),
                        child: (itemID != 0)
                            ? util.getItemIcon(itemID)
                            : CustomWidgets.getEmtpyItem(context),
                        width:
                            min(constraints.maxWidth / 7, (ROW_HEIGHT) * 0.8),
                        height:
                            min(constraints.maxWidth / 7, (ROW_HEIGHT) * 0.8),
                      ))
                  .toList(),
            );
          },
        ),
      );

      return Container(
        height: ROW_HEIGHT + 2 * PADDING_BETWEEN_ROWS,
        child: Stack(
          children: <Widget>[
            Opacity(
              opacity: 0.3,
              child: Container(
                width: DeviceSizes.getWidth(context: context),
                height: ROW_HEIGHT + 2 * PADDING_BETWEEN_ROWS,
                color: color,
              ),
            ),
            Container(
//              color: Colors.transparent,
              padding: EdgeInsets.all(PADDING_BETWEEN_ROWS),
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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DropdownButton<String>(
              value: dropdownValue,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24 * DeviceSizes.getScaleFactor(context: context),
              elevation:
                  17 * DeviceSizes.getScaleFactor(context: context).toInt(),
              style: TextStyle(color: Colors.white),
              underline: Container(
                height: 2 * DeviceSizes.getScaleFactor(context: context),
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
                  child: Text(
                    value,
                    style: TextStyle(
                        fontSize:
                            12.0 * DeviceSizes.getScaleFactor(context: context)),
                  ),
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
                    Tab(
                      text: 'Main Table',
                    ),
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
  _GameStatsTableScreenState createState() =>
      _GameStatsTableScreenState(game: game);
}

class _GameStatsTableScreenState extends State<GameStatsTableScreen> {
  final Game game;

  _GameStatsTableScreenState({this.game});

  List<PlayerGameStats> playersList;

  @override
  Widget build(BuildContext context) {
    final double ROW_HEIGHT = 40 * DeviceSizes.getScaleFactor(context: context);

    Widget getGameStatsTable() {
      DataCell getDataCell(Widget child, {bool isAvatar=false, int index, PlayerData player}) {
        Color opacityColor =
            index < 5 ? AppColors.blueTeamColor : AppColors.redTeamColor;
        if (game.summonerName == player.summonerName) {
          opacityColor = Colors.amberAccent;
        }
        return DataCell(
          Container(
            width: isAvatar ? ROW_HEIGHT + 6.0 : (DeviceSizes.getWidth(context: context)-(ROW_HEIGHT + 6.0))/5,
            child: Stack(
              children: <Widget>[
                Container(
                  color: index < 5
                      ? AppColors.blueTeamColor
                      : AppColors.redTeamColor,
                ),
                Opacity(
                  opacity: 0.3,
                  child: Container(
                    color: opacityColor,
                  ),
                ),
                Container(
                  child: Align(
                    child: child,
                    alignment: Alignment.center,
                  ),
                ),
              ],
            ),
          ),
        );
      }

      DataColumn getDataColumn(String columnName, {isAvatar = false}) {
        return DataColumn(
            label: Expanded(
              child: Container(
                width: isAvatar
                    ? ROW_HEIGHT / 2 * 1.5
                    : 55 * DeviceSizes.getScaleFactor(context: context),
                child: Text(
                  columnName,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 12 * DeviceSizes.getScaleFactor(context: context),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            numeric: true);
      }

      Widget getChampCircleAvatar({PlayerData player}) {
        return Container(
          child: CircleAvatar(
            backgroundColor: player.summonerName == game.summonerName
                ? Colors.amberAccent
                : Colors.transparent,
            radius: ROW_HEIGHT / 2,
            child: CircleAvatar(
              backgroundImage: util
                  .getChampionAvatar(
                      ConstData.championsIdsNames[player.championID.toString()])
                  .image,
              radius: (ROW_HEIGHT / 2) * 0.9,
            ),
          ),
        );
      }

      Widget gameStatsTable = Container(
        child: Column(
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                color: baseTheme.primaryColor,
                child: DataTable(
                  dataRowHeight: ROW_HEIGHT + 6.0,
                  headingRowHeight:
                      40.0 * DeviceSizes.getScaleFactor(context: context),
                  horizontalMargin: 0.0,
                  columnSpacing: 1.0,
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
                              getChampCircleAvatar(player: player),
                              player: player,
                              isAvatar: true,
                              index: game.playersData.indexOf(player),
                            ),
                            getDataCell(
                              Text(player.goldEarned.toString(), style: TextStyle(fontSize: 12.0 * DeviceSizes.getScaleFactor(context: context)),),
                              player: player,
                              index: game.playersData.indexOf(player),
                            ),
                            getDataCell(
                              Text(player.visionScore.toString(), style: TextStyle(fontSize: 12.0 * DeviceSizes.getScaleFactor(context: context)),),
                              player: player,
                              index: game.playersData.indexOf(player),
                            ),
                            getDataCell(
                                Text(player.totalDamageDealtToChampions
                                    .toString(), style: TextStyle(fontSize: 12.0 * DeviceSizes.getScaleFactor(context: context)),),
                                player: player,
                                index: game.playersData.indexOf(player)),
                            getDataCell(
                              Text(player.totalDamageTaken.toString(), style: TextStyle(fontSize: 12.0 * DeviceSizes.getScaleFactor(context: context)),),
                              player: player,
                              index: game.playersData.indexOf(player),
                            ),
                            getDataCell(
                              Text(player.totalHeal.toString(), style: TextStyle(fontSize: 12.0 * DeviceSizes.getScaleFactor(context: context)),),
                              player: player,
                              index: game.playersData.indexOf(player),
                            ),
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

    return getGameStatsTable();

  }
}
