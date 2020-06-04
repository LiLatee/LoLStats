//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:lolstats/common/CustomWidgets.dart' as CustomWidgets;
//import 'package:lolstats/common/themes.dart';
//import 'package:lolstats/models/KDA.dart';
//import 'package:lolstats/common/AppColors.dart' as AppColors;
//import 'package:lolstats/common/AppBars.dart' as AppBars;
//import 'package:lolstats/models/PlayerGameStats.dart';
//import 'package:charts_flutter/flutter.dart' as charts;
//
//class GameStatsTableScreen extends StatefulWidget {
//  @override
//  _GameStatsTableScreenState createState() => _GameStatsTableScreenState();
//}
//
//class _GameStatsTableScreenState extends State<GameStatsTableScreen> {
//  bool sort;
//  List<PlayerGameStats> playersList;
//  NetworkImage asheIcon;
//
//  @override
//  void initState() {
//    asheIcon = NetworkImage(
//        'https://gamepedia.cursecdn.com/lolesports_gamepedia_en/4/4a/AsheSquare.png');
//    sort = false;
//    playersList = [
//      PlayerGameStats(
//          kda: KDA(kills: 5, deaths: 2, assists: 8), damageTaken: 3003, damageHealed: 123134, damageDealt: 345, goldEarned: 123, visionScore: 999, champIcon: asheIcon, isWin: true),
//      PlayerGameStats(
//          kda: KDA(kills: 5, deaths: 2, assists: 8), damageTaken: 3003, damageHealed: 123134, damageDealt: 345, goldEarned: 123, visionScore: 999, champIcon: asheIcon, isWin: true),
//      PlayerGameStats(
//          kda: KDA(kills: 5, deaths: 2, assists: 8), damageTaken: 3003, damageHealed: 123134, damageDealt: 345, goldEarned: 123, visionScore: 999, champIcon: asheIcon, isWin: true),
//      PlayerGameStats(
//          kda: KDA(kills: 5, deaths: 2, assists: 8), damageTaken: 3003, damageHealed: 123134, damageDealt: 345, goldEarned: 123, visionScore: 999, champIcon: asheIcon, isWin: true),
//      PlayerGameStats(
//          kda: KDA(kills: 5, deaths: 2, assists: 8), damageTaken: 3003, damageHealed: 123134, damageDealt: 345, goldEarned: 123, visionScore: 999, champIcon: asheIcon, isWin: true),
//      PlayerGameStats(
//          kda: KDA(kills: 5, deaths: 2, assists: 8), damageTaken: 3003, damageHealed: 123134, damageDealt: 345, goldEarned: 123, visionScore: 999, champIcon: asheIcon, isWin: true),
//      PlayerGameStats(
//          kda: KDA(kills: 5, deaths: 2, assists: 8), damageTaken: 3003, damageHealed: 123134, damageDealt: 345, goldEarned: 123, visionScore: 999, champIcon: asheIcon, isWin: true),
//      PlayerGameStats(
//          kda: KDA(kills: 5, deaths: 2, assists: 8), damageTaken: 3003, damageHealed: 123134, damageDealt: 345, goldEarned: 123, visionScore: 999, champIcon: asheIcon, isWin: true),
//      PlayerGameStats(
//          kda: KDA(kills: 5, deaths: 2, assists: 8), damageTaken: 3003, damageHealed: 123134, damageDealt: 345, goldEarned: 123, visionScore: 999, champIcon: asheIcon, isWin: true),
//      PlayerGameStats(
//          kda: KDA(kills: 5, deaths: 2, assists: 8), damageTaken: 3003, damageHealed: 123134, damageDealt: 345, goldEarned: 123, visionScore: 999, champIcon: asheIcon, isWin: true),
//    ];
//    super.initState();
//  }
//
//
//
//  @override
//  Widget build(BuildContext context) {
//    const double CHAMP_AVATAR_SIZE = 18.0;
//    const double EDGE_INSECTS_IN_TEAMS_INFO = 8.0;
//
//    Widget getGameStatsTable() {
//      DataCell getDataCell(Widget child, {int index}) {
//        return DataCell(
//          Row(
//            crossAxisAlignment: CrossAxisAlignment.stretch,
//            children: <Widget>[
//              Expanded(
//                child: Container(
//                    width: 20,
//                    color: index < 5
//                        ? AppColors.blueTeamColor
//                        : AppColors.redTeamColor,
//                    child: Align(
//                      child: child,
//                      alignment: Alignment.center,
//                    )),
//              ),
//            ],
//          ),
//        );
//      }
//
//      DataColumn getDataColumn(String columnName, {isAvatar = false}) {
//        return DataColumn(
//            label: Container(
//              width: isAvatar ? CHAMP_AVATAR_SIZE * 1.5 : 55,
//              child: Text(
//                columnName,
//                softWrap: true,
//                style: Theme.of(context).textTheme.headline4,
//              ),
//            ),
//            numeric: true);
//      }
//
//      Widget gameStatsTable = Container(
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.stretch,
//          children: <Widget>[
////            CustomWidgets.getNewSectionText(context, "Statistics - Table"),
//            SingleChildScrollView(
//              scrollDirection: Axis.horizontal,
//              child: Container(
//                color: baseTheme.primaryColor,
//                child: DataTable(
//                  headingRowHeight: 50.0,
//                  horizontalMargin: 0.0,
//                  columnSpacing: 0.0,
//                  columns: [
//                    getDataColumn('', isAvatar: true),
//                    getDataColumn('Gold Earned'),
//                    getDataColumn('Vision Score'),
//                    getDataColumn('Damage Dealt'),
//                    getDataColumn('Damage Taken'),
//                    getDataColumn('Damage Healed'),
//                  ],
//                  rows: playersList
//                      .map(
//                        (player) => DataRow(
//                          cells: [
//                            getDataCell(
//                                Container(
//                                  padding: EdgeInsets.only(
//                                      left: EDGE_INSECTS_IN_TEAMS_INFO),
//                                  child: CircleAvatar(
//                                    backgroundImage: NetworkImage(
//                                        'https://gamepedia.cursecdn.com/lolesports_gamepedia_en/4/4a/AsheSquare.png'),
//                                    radius: CHAMP_AVATAR_SIZE,
//                                  ),
//                                ),
//                                index: playersList.indexOf(player)),
//                            getDataCell(Text(player.goldEarned.toString()),
//                                index: playersList.indexOf(player)),
//                            getDataCell(Text(player.visionScore.toString()),
//                                index: playersList.indexOf(player)),
//                            getDataCell(Text(player.damageDealt.toString()),
//                                index: playersList.indexOf(player)),
//                            getDataCell(Text(player.damageTaken.toString()),
//                                index: playersList.indexOf(player)),
//                            getDataCell(Text(player.damageHealed.toString()),
//                                index: playersList.indexOf(player)),
//                          ],
//                        ),
//                      )
//                      .toList(),
//                ),
//              ),
//            ),
//          ],
//        ),
//      );
//      return gameStatsTable;
//    }
//
//    ///////////    wykres proba
////    return Scaffold(
////      appBar: AppBars.baseAppBar(context),
////      body: Container(
////        child: Stack(
////          children: <Widget>[
////            StackedHorizontalBarChart.withSampleData(),
////            Positioned(
////                child: Image(image: asheIcon,),
////              height: 30,
////              width: 30,
////              top: 80 ,
////            ),
////          ],
////        ),
////      ),
////    );
//
//    return Container(
//        child: ListView(
//          children: <Widget>[
//            getGameStatsTable(),
//          ],
//        ),
//    );
//  }
//}

///// Bar chart example
//class StackedHorizontalBarChart extends StatelessWidget {
//  final List<charts.Series> seriesList;
//  final bool animate;
//
//  StackedHorizontalBarChart(this.seriesList, {this.animate});
//
//  /// Creates a stacked [BarChart] with sample data and no transition.
//  factory StackedHorizontalBarChart.withSampleData() {
//    return new StackedHorizontalBarChart(
//      _createSampleData(),
//      // Disable animations for image tests.
//      animate: false,
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    // For horizontal bar charts, set the [vertical] flag to false.
//    return new charts.BarChart(
//      seriesList,
//      animate: animate,
//      barGroupingType: charts.BarGroupingType.grouped,
//      vertical: false,
//    );
//  }
//

//
//  /// Create series list with multiple series
//  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
//    NetworkImage asheIcon = NetworkImage(
//        'https://gamepedia.cursecdn.com/lolesports_gamepedia_en/4/4a/AsheSquare.png');
//    final desktopSalesData = [
//      new OrdinalSales('2014', 5, image: asheIcon),
//      new OrdinalSales('2015', 25, image: asheIcon),
//      new OrdinalSales('2016', 100, image: asheIcon),
//      new OrdinalSales('2017', 75, image: asheIcon),
//    ];
//
//    final tableSalesData = [
//      new OrdinalSales('2014', 25, image: asheIcon),
//      new OrdinalSales('2015', 50, image: asheIcon),
//      new OrdinalSales('2016', 10, image: asheIcon),
//      new OrdinalSales('2017', 20, image: asheIcon),
//    ];
//
//    final mobileSalesData = [
//      new OrdinalSales('2014', 10, image: asheIcon),
//      new OrdinalSales('2015', 15, image: asheIcon),
//      new OrdinalSales('2016', 50, image: asheIcon),
//      new OrdinalSales('2017', 45, image: asheIcon),
//    ];
//
//    return [
//      new charts.Series<OrdinalSales, String>(
//        id: 'Desktop',
//        domainFn: (OrdinalSales sales, _) => sales.year,
//        measureFn: (OrdinalSales sales, _) => sales.sales,
//        data: desktopSalesData,
//      ),
//      new charts.Series<OrdinalSales, String>(
//        id: 'Tablet',
//        domainFn: (OrdinalSales sales, _) => sales.year,
//        measureFn: (OrdinalSales sales, _) => sales.sales,
//        data: tableSalesData,
//      ),
//      new charts.Series<OrdinalSales, String>(
//        id: 'Mobile',
//        domainFn: (OrdinalSales sales, _) => sales.year,
//        measureFn: (OrdinalSales sales, _) => sales.sales,
//        data: mobileSalesData,
//      ),
//    ];
//  }
//}
//
///// Sample ordinal data type.
//class OrdinalSales {
//  final String year;
//  final int sales;
//  final NetworkImage image;
//
//  OrdinalSales(this.year, this.sales, {this.image = null});
//}
