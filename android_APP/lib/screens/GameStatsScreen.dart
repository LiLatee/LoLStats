import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lolstats/common/CustomWidgets.dart' as CustomWidgets;
import 'package:lolstats/common/themes.dart';
import 'package:lolstats/models/KDA.dart';
import 'package:lolstats/common/AppColors.dart' as AppColors;
import 'package:lolstats/common/AppBars.dart' as AppBars;
import 'package:lolstats/models/PlayerGameStats.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class GameStatsScreen extends StatefulWidget {
  @override
  _GameStatsScreenState createState() => _GameStatsScreenState();
}

class _GameStatsScreenState extends State<GameStatsScreen> {
  bool sort;
  List<PlayerGameStats> playersList;
  NetworkImage asheIcon;

  @override
  void initState() {
    asheIcon = NetworkImage(
        'https://gamepedia.cursecdn.com/lolesports_gamepedia_en/4/4a/AsheSquare.png');
    sort = false;
    playersList = [
      PlayerGameStats(
          KDA(5, 2, 8), 3003, 123134, 345, 123, 999, asheIcon, true),
      PlayerGameStats(
          KDA(5, 2, 8), 4000, 123134, 345, 123, 888, asheIcon, true),
      PlayerGameStats(KDA(5, 2, 8), 222, 123134, 345, 123, 999, asheIcon, true),
      PlayerGameStats(
          KDA(5, 2, 8), 3003, 123134, 345, 123, 444, asheIcon, true),
      PlayerGameStats(
          KDA(5, 2, 8), 3003, 123134, 345, 123, 666, asheIcon, true),
      PlayerGameStats(
          KDA(5, 2, 8), 3003, 123134, 345, 123, 999, asheIcon, false),
      PlayerGameStats(
          KDA(5, 2, 8), 4000, 123134, 345, 123, 888, asheIcon, false),
      PlayerGameStats(
          KDA(5, 2, 8), 222, 123134, 345, 123, 999, asheIcon, false),
      PlayerGameStats(
          KDA(5, 2, 8), 3003, 123134, 345, 123, 444, asheIcon, false),
      PlayerGameStats(
          KDA(5, 2, 8), 3003, 123134, 345, 123, 666, asheIcon, false)
    ];
    super.initState();
  }

  void onSortColumn(int columnIndex, bool ascending, String columnName) {
    if (ascending) {
      playersList.sort((a, b) => a
          .getAttributeByName(columnName)
          .compareTo(b.getAttributeByName(columnName)));
    } else {
      playersList.sort((a, b) => b
          .getAttributeByName(columnName)
          .compareTo(a.getAttributeByName(columnName)));
    }
  }

  @override
  Widget build(BuildContext context) {
    const double CHAMP_AVATAR_SIZE = 18.0;
    const double EDGE_INSECTS_IN_TEAMS_INFO = 8.0;

    Widget createRow(NetworkImage champIcon, String playerName, KDA kda) {
      Widget avatarSection = CircleAvatar(
        backgroundImage: champIcon,
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

      Widget nickAndCsSection = Container(
        padding: EdgeInsets.only(left: EDGE_INSECTS_IN_TEAMS_INFO),
        child: Column(
          children: <Widget>[
            Text(
              playerName,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
            ),
            Text("CS: " + 123.toString(), style: TextStyle(fontSize: 12)),
          ],
        ),
      );

      String kdaRatio = kda.deaths > 0
          ? ((kda.kills + kda.assists) / kda.deaths).toString()
          : ((kda.kills + kda.assists) / 1).toString();
      Widget kdaSection = Container(
        padding: EdgeInsets.only(left: EDGE_INSECTS_IN_TEAMS_INFO),
        child: Column(
          children: <Widget>[
            Text(kda.toString()),
            Text(kdaRatio.toString(), style: TextStyle(fontSize: 12)),
          ],
        ),
      );

      Image exampleItem = Image.network(
        'https://vignette.wikia.nocookie.net/leagueoflegends/images/9/9f/Warmog%27s_Armor_item.png/revision/latest?cb=20171222001951',
        width: CHAMP_AVATAR_SIZE * 1.5,
        height: CHAMP_AVATAR_SIZE * 1.5,
      );
      Widget emptyItem = Opacity(
        opacity: 0.7,
        child: Container(
          width: CHAMP_AVATAR_SIZE * 1.5,
          height: CHAMP_AVATAR_SIZE * 1.5,
          color: Colors.grey,
        ),
      );

      Widget itemsSection = Container(
        padding: EdgeInsets.only(left: EDGE_INSECTS_IN_TEAMS_INFO),
        child: Row(
          children: <Widget>[
            exampleItem,
            exampleItem,
            exampleItem,
            exampleItem,
            exampleItem,
            emptyItem,
          ],
        ),
      );

      return Container(
        padding: EdgeInsets.all(5.0),
        child: Row(
          children: <Widget>[
            avatarSection,
            spellsRunesSection,
            nickAndCsSection,
            kdaSection,
            itemsSection,
          ],
        ),
      );
    }

    Widget blueTeamTable = Container(
      color: AppColors.blueTeamColor,
      child: Column(
        children: <Widget>[
          createRow(
              NetworkImage(
                  'https://gamepedia.cursecdn.com/lolesports_gamepedia_en/4/4a/AsheSquare.png'),
              "Jeyol",
              KDA(10, 4, 5)),
          createRow(
              NetworkImage(
                  'https://gamepedia.cursecdn.com/lolesports_gamepedia_en/4/4a/AsheSquare.png'),
              "Jeyol",
              KDA(10, 4, 5)),
          createRow(
              NetworkImage(
                  'https://gamepedia.cursecdn.com/lolesports_gamepedia_en/4/4a/AsheSquare.png'),
              "Jeyol",
              KDA(10, 4, 5)),
          createRow(
              NetworkImage(
                  'https://gamepedia.cursecdn.com/lolesports_gamepedia_en/4/4a/AsheSquare.png'),
              "Jeyol",
              KDA(10, 4, 5)),
          createRow(
              NetworkImage(
                  'https://gamepedia.cursecdn.com/lolesports_gamepedia_en/4/4a/AsheSquare.png'),
              "Jeyol",
              KDA(10, 4, 5)),
        ],
      ),
    );
    Widget redTeamTable = Container(
      color: AppColors.redTeamColor,
      child: Column(
        children: <Widget>[
          createRow(
              NetworkImage(
                  'https://gamepedia.cursecdn.com/lolesports_gamepedia_en/4/4a/AsheSquare.png'),
              "Jeyol",
              KDA(10, 4, 5)),
          createRow(
              NetworkImage(
                  'https://gamepedia.cursecdn.com/lolesports_gamepedia_en/4/4a/AsheSquare.png'),
              "Jeyol",
              KDA(10, 4, 5)),
          createRow(
              NetworkImage(
                  'https://gamepedia.cursecdn.com/lolesports_gamepedia_en/4/4a/AsheSquare.png'),
              "Jeyol",
              KDA(10, 4, 5)),
          createRow(
              NetworkImage(
                  'https://gamepedia.cursecdn.com/lolesports_gamepedia_en/4/4a/AsheSquare.png'),
              "Jeyol",
              KDA(10, 4, 5)),
          createRow(
              NetworkImage(
                  'https://gamepedia.cursecdn.com/lolesports_gamepedia_en/4/4a/AsheSquare.png'),
              "Jeyol",
              KDA(10, 4, 5)),
        ],
      ),
    );

    Widget getGameStatsTable() {
      DataCell getDataCell(Widget child, {int index}) {
        return DataCell(
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Container(
                    width: 20,
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
            CustomWidgets.getNewSectionText(context, "Statistics - Table"),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                color: baseTheme.primaryColor,
                child: DataTable(
                  headingRowHeight: 50.0,
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
                  rows: playersList
                      .map(
                        (player) => DataRow(
                          cells: [
                            getDataCell(
                                Container(
                                  padding: EdgeInsets.only(
                                      left: EDGE_INSECTS_IN_TEAMS_INFO),
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        'https://gamepedia.cursecdn.com/lolesports_gamepedia_en/4/4a/AsheSquare.png'),
                                    radius: CHAMP_AVATAR_SIZE,
                                  ),
                                ),
                                index: playersList.indexOf(player)),
                            getDataCell(Text(player.goldEarned.toString()),
                                index: playersList.indexOf(player)),
                            getDataCell(Text(player.visionScore.toString()),
                                index: playersList.indexOf(player)),
                            getDataCell(Text(player.damageDealt.toString()),
                                index: playersList.indexOf(player)),
                            getDataCell(Text(player.damageTaken.toString()),
                                index: playersList.indexOf(player)),
                            getDataCell(Text(player.damageHealed.toString()),
                                index: playersList.indexOf(player)),
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

    Widget getGameStatsTable2() {
      List<Widget> _buildCells(int count) {
        return List.generate(
          count,
          (index) => Container(
            alignment: Alignment.center,
//            width: 120.0,
//            height: 60.0,
            color: Colors.white,
            margin: EdgeInsets.all(4.0),
            child:
                Text("${index + 1}", style: Theme.of(context).textTheme.title),
          ),
        );
      }

      List<Widget> _buildRows(int count) {
        return List.generate(
          count,
          (index) => Row(
            children: _buildCells(30),
          ),
        );
      }

      Widget getAvatar() => CircleAvatar(
            backgroundImage: asheIcon,
            radius: CHAMP_AVATAR_SIZE,
          );

      Widget gameStatsTable = SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                10,
                (index) => getAvatar(),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildRows(10),
                ),
              ),
            ),
          ],
        ),
      );

      return gameStatsTable;
    }

///////////    wykres proba
//    return Scaffold(
//      appBar: AppBars.baseAppBar(context),
//      body: Container(
//        child: Stack(
//          children: <Widget>[
//            StackedHorizontalBarChart.withSampleData(),
//            Positioned(
//                child: Image(image: asheIcon,),
//              height: 30,
//              width: 30,
//              top: 80 ,
//            ),
//          ],
//        ),
//      ),
//    );

    return Scaffold(
      appBar: AppBars.baseAppBar(context),
      body: Container(
        child: ListView(
          children: <Widget>[
            CustomWidgets.getNewSectionText(context, "Player Statistics"),
            redTeamTable,
            blueTeamTable,
            getGameStatsTable(),
          ],
        ),
      ),
    );
  }
}

/// Bar chart example
class StackedHorizontalBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  StackedHorizontalBarChart(this.seriesList, {this.animate});

  /// Creates a stacked [BarChart] with sample data and no transition.
  factory StackedHorizontalBarChart.withSampleData() {
    return new StackedHorizontalBarChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    // For horizontal bar charts, set the [vertical] flag to false.
    return new charts.BarChart(
      seriesList,
      animate: animate,
      barGroupingType: charts.BarGroupingType.grouped,
      vertical: false,
    );
  }

  /// Create series list with multiple series
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    NetworkImage asheIcon = NetworkImage(
        'https://gamepedia.cursecdn.com/lolesports_gamepedia_en/4/4a/AsheSquare.png');
    final desktopSalesData = [
      new OrdinalSales('2014', 5, image: asheIcon),
      new OrdinalSales('2015', 25, image: asheIcon),
      new OrdinalSales('2016', 100, image: asheIcon),
      new OrdinalSales('2017', 75, image: asheIcon),
    ];

    final tableSalesData = [
      new OrdinalSales('2014', 25, image: asheIcon),
      new OrdinalSales('2015', 50, image: asheIcon),
      new OrdinalSales('2016', 10, image: asheIcon),
      new OrdinalSales('2017', 20, image: asheIcon),
    ];

    final mobileSalesData = [
      new OrdinalSales('2014', 10, image: asheIcon),
      new OrdinalSales('2015', 15, image: asheIcon),
      new OrdinalSales('2016', 50, image: asheIcon),
      new OrdinalSales('2017', 45, image: asheIcon),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Desktop',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: desktopSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Tablet',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: tableSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Mobile',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: mobileSalesData,
      ),
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;
  final NetworkImage image;

  OrdinalSales(this.year, this.sales, {this.image = null});
}
