import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lolstats/BaseAppBar.dart';
import 'package:lolstats/util.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreen createState() => _UserScreen();
}

class _UserScreen extends State<UserScreen> {
  int soloDuoWins = 30;
  int soloDuoLosses = 35;
  String soloDuoDivision = "Diamond 3";

  int flexWins = 30;
  int flexLosses = 30;
  String flexDivision = "Platinum 3";

  int normalWins = 300;
  int normalLosses = 350;

  Widget getGamesStatsText(String queueType, int wins, int losses,
      [String division = "", exampleDivisionIconLink = null]) {
    double ratio = roundDouble(wins / (wins + losses) * 100, 2);

    Widget divisionIcon;
    if (exampleDivisionIconLink != null) {
      divisionIcon = Image.network(exampleDivisionIconLink);
    } else {
      divisionIcon = Container(
        width: 0,
        height: 0,
      );
    }
    return Expanded(
      child: Row(children: [
        RichText(
          text: TextSpan(
              text: queueType,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 15,
              ),
              children: [
                TextSpan(
                    text: "$soloDuoWins/$soloDuoLosses ($ratio%) " + division,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                    )),
              ]),
        ),
        divisionIcon,
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    String exampleDivisionIconLink =
        "https://vignette.wikia.nocookie.net/leagueoflegends/images/d/dc/Season_2019_-_Diamond_3.png/revision/latest/zoom-crop/width/90/height/55?cb=20181229234918";

    Widget topRowOfMainInfoSection = Expanded(
      flex: 1,
      child: Row(
        children: <Widget>[
          Container(
            width: 100,
            height: 100,
            margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
            child: Image.network(
              'https://vignette.wikia.nocookie.net/leagueoflegends/images/8/8f/Arcade_Star_profileicon.png/revision/latest/scale-to-width-down/48?cb=20190802024813',
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Text(
                  "Nickname",
                  softWrap: true,
                  style: TextStyle(
                    shadows: [
                      Shadow(
                        // bottomLeft
                          offset: Offset(-1, -1),
                          color: Colors.white),
                      Shadow(
                        // bottomRight
                          offset: Offset(1, -1),
                          color: Colors.white),
                      Shadow(
                        // topRight
                          offset: Offset(1, 1),
                          color: Colors.white),
                      Shadow(
                        // topLeft
                          offset: Offset(-1, 1),
                          color: Colors.white),
                    ],
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    Widget botRowOfMainInfoSection = Expanded(
      flex: 1,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  getGamesStatsText("Solo/Duo: ", soloDuoWins, soloDuoLosses,
                      "Diamond 4", exampleDivisionIconLink),
                  getGamesStatsText("Flex: ", flexWins, flexLosses,
                      "Platinum 3", exampleDivisionIconLink),
                  getGamesStatsText(
                      "Normal: ", normalWins, normalLosses, "", null),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    Widget mainInfoSection = Container(
      height: 220,
      child: Card(
        elevation: 5,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Opacity(
              opacity: 0.6,
              child: Image.network(
                'https://ddragon.leagueoflegends.com/cdn/img/champion/splash/Ashe_0.jpg',
                fit: BoxFit.fill,
              ),
            ),
            Container(
              child: Column(
//                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  topRowOfMainInfoSection,
                  botRowOfMainInfoSection,
                ],
              ),
            ),
          ],
        ),
      ),
    );

    Widget matchHistory() {
      return Expanded(
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: <Widget>[
            Container(
              width: double.maxFinite,
              height: 100,
              color: Colors.red,
            ),
            Container(
              width: double.maxFinite,
              height: 100,
              color: Colors.blue,
            ),
            Container(
              width: double.maxFinite,
              height: 100,
              color: Colors.green,
            ),
            Container(
              width: double.maxFinite,
              height: 100,
              color: Colors.red,
            ),
            Container(
              width: double.maxFinite,
              height: 100,
              color: Colors.blue,
            ),
            Container(
              width: double.maxFinite,
              height: 100,
              color: Colors.green,
            ),
            Container(
              width: double.maxFinite,
              height: 100,
              color: Colors.red,
            ),
            Container(
              width: double.maxFinite,
              height: 100,
              color: Colors.blue,
            ),
            Container(
              width: double.maxFinite,
              height: 100,
              color: Colors.green,
            ),
          ],
        ),
      );
    }

//    const _colorsList = [
//      Colors.red,
//      Colors.blue,
//      Colors.green,
//      Colors.red,
//      Colors.blue,
//      Colors.green,
//      Colors.red,
//      Colors.blue,
//      Colors.green,
//      Colors.red,
//      Colors.blue,
//      Colors.green,
//      Colors.red,
//      Colors.blue,
//      Colors.green,
//      Colors.red,
//      Colors.blue,
//      Colors.green,
//      Colors.red,
//      Colors.blue,
//      Colors.green,
//      Colors.red,
//      Colors.blue,
//      Colors.green,
//      Colors.red,
//      Colors.blue,
//      Colors.green,
//      Colors.red,
//      Colors.blue,
//      Colors.green,
//      Colors.red,
//      Colors.blue,
//      Colors.green,
//      Colors.red,
//      Colors.blue,
//      Colors.green,
//    ];
//
//
//    Widget _buildTile(BuildContext context, Color color) {
//      return Container(
//          width: double.maxFinite,
//          height: 100,
//          color: color
//      );
//    }
//    return Scaffold(
//      body: CustomScrollView(
//        slivers: [
//          BaseAppBar.getBaseSliverAppBar(context),
//          SliverList(
//            delegate: SliverChildBuilderDelegate(
//                  (context, index) => _buildTile(context, _colorsList[index]),
//              childCount: _colorsList.length,
//            ),
//          ),
////          SliverToBoxAdapter(child: SizedBox(height: 12)),
////          SliverList(
////            delegate: SliverChildBuilderDelegate(
////                    (context, index) => _MyListItem(index)),
////          ),
//        ],
//      ),
//    );

    return SafeArea(
        child: Scaffold(
            appBar: BaseAppBar.getBaseAppBar(context),
            body: Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                children: <Widget>[
                  mainInfoSection,
                  matchHistory(),
                ],
              ),
            )));
  }
}
