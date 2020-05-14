import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lolstats/common/themes.dart';
import 'file:///D:/Dokumenty/Projekty/AndroidStudioProjects/lol_stats/lib/common/AppBars.dart' as AppBars;
import 'file:///D:/Dokumenty/Projekty/AndroidStudioProjects/lol_stats/lib/common/util.dart';
import 'package:lolstats/models/Champion.dart';

import 'package:lolstats/models/Game.dart';
import 'package:lolstats/models/KDA.dart';
import 'package:lolstats/screens/GameStatsScreen.dart';
import '../common/TextStyles.dart' as MyTextStyles;

class UserScreen extends StatefulWidget {
  @override
  _UserScreen createState() => _UserScreen();
}

class _UserScreen extends State<UserScreen> {
  ThemeData myTheme;
  int soloDuoWins = 30;
  int soloDuoLosses = 35;
  String soloDuoDivision = "Diamond 3";

  int flexWins = 30;
  int flexLosses = 30;
  String flexDivision = "Platinum 3";

  int normalWins = 300;
  int normalLosses = 350;

  Image mostPopularChampImage = Image.network(
      "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/Ashe_0.jpg",
      fit: BoxFit.fill);

  List<Game> _games = [
    Game(Champion("Zed"), true, KDA(3, 1, 5), 23, 55),
    Game(Champion("Zed"), true, KDA(3, 1, 5), 23, 55),
    Game(Champion("Zed"), true, KDA(3, 1, 5), 23, 55),
    Game(Champion("Zed"), true, KDA(3, 1, 5), 23, 55),
    Game(Champion("Sejuani"), false, KDA(5, 1, 3), 23, 55),
    Game(Champion("Zed"), true, KDA(3, 1, 5), 23, 55),
    Game(Champion("Zed"), true, KDA(3, 1, 5), 23, 55),
    Game(Champion("Zed"), true, KDA(3, 1, 5), 23, 55),
    Game(Champion("Zed"), true, KDA(3, 1, 5), 23, 55),
    Game(Champion("Zed"), true, KDA(3, 1, 5), 23, 55),
    Game(Champion("Zed"), true, KDA(3, 1, 5), 23, 55),
    Game(Champion("Zed"), true, KDA(3, 1, 5), 23, 55),
    Game(Champion("Zed"), true, KDA(3, 1, 5), 23, 55),
    Game(Champion("Zed"), true, KDA(3, 1, 5), 23, 55),
    Game(Champion("Zed"), true, KDA(3, 1, 5), 23, 55),
    Game(Champion("Zed"), true, KDA(3, 1, 5), 23, 55),
    Game(Champion("Zed"), true, KDA(3, 1, 5), 23, 55),
    Game(Champion("Zed"), true, KDA(3, 1, 5), 23, 55),
    Game(Champion("Zed"), true, KDA(3, 1, 5), 23, 55),
    Game(Champion("Zed"), true, KDA(3, 1, 5), 23, 55),
    Game(Champion("Zed"), true, KDA(3, 1, 5), 23, 55),
    Game(Champion("Zed"), true, KDA(3, 1, 5), 23, 55),
    Game(Champion("Zed"), true, KDA(3, 1, 5), 23, 55),
    Game(Champion("Zed"), true, KDA(3, 1, 5), 23, 55),
    Game(Champion("Zed"), true, KDA(3, 1, 5), 23, 55),
  ];

  int perPage = 10;
  int present = 0;

  List<Game> items = List<Game>();

  @override
  void initState() {
    super.initState();
    setState(() {
      items.addAll(_games.getRange(present, present + perPage));
      present = present + perPage;
    });
  }

  void loadMore() {
    setState(() {
//      log("_games.length: " + _games.length.toString());
//      log("present: " + present.toString());
//      log("perPage: " + perPage.toString());
      // todo wywala się, jak jest równo lub mniej elementów co perPage
      if ((present + perPage) > _games.length) {
//        log("111");
        items.addAll(_games.getRange(present, _games.length - 1));
      } else {
//        log("222");
        items.addAll(_games.getRange(present, present + perPage));
      }
      present = present + perPage;
      if (present > _games.length) {
        present = _games.length - 1;
      }
    });
  }

  void _fetchNetworkData(String champImageURL) async {
    Image image = await Image.network(
      "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/Ashe_0.jpg",
      fit: BoxFit.fill,
    );
    mostPopularChampImage = image;
  }

  Widget _buildTile(int index) {
    Game game = _games[index];
    Color color = game.isWin ? Colors.green[400] : Colors.red[400];
    String gameResult = (game.isWin) ? "Win" : "Lose";
    String imageURL =
        "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/" +
            game.champion.name +
            "_0.jpg";
//    String imageURL = "https://vignette.wikia.nocookie.net/leagueoflegends/images/8/8f/Arcade_Star_profileicon.png/revision/latest/scale-to-width-down/48?cb=20190802024813";
    Image image = Image.network(
      imageURL,
      fit: BoxFit.fitWidth,
    );

//    return Container(
//      height: 100,
////      color: color,
//      child: Card(
//        color: color,
//        elevation: 5,
//        child: Stack(
//            fit: StackFit.expand,
//            children: [
//              Opacity(
//                opacity: 0.6,
//                child: Container(
//                  decoration: BoxDecoration(
//                    image: DecorationImage(fit: BoxFit.fitWidth,
//                        alignment: FractionalOffset.topCenter,
//                        image: NetworkImage(imageURL)),
//                  ),
//                ),
//              ),
//              Opacity(
//                opacity: 0.3,
//                child: Container(
//                  color: Colors.white,
//                ),
//              ),
//        ListTile(
//          title: Text(game.KDA['kills'].toString() +
//              "/" +
//              game.KDA['deaths'].toString() +
//              "/" +
//              game.KDA['assists'].toString()),
//          subtitle:
//          Text(game.minutes.toString() + ":" + game.seconds.toString()),
//          leading: Container(
//            width: 50,
//            child: Text(
//              gameResult,
//              overflow: TextOverflow.ellipsis,
//              softWrap: false,
//              style: MyTextStyles.gameResult,
//
//            ),
//          ),
//        ),
//            ]),
//      ),
//    );

    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => GameStatsScreen())),
      child: Card(
        elevation: 5,
        child: Container(
          color: color,
          child: ListTile(
            leading: image,
            title: Text(game.kda.toString()),
            subtitle:
                Text(game.minutes.toString() + ":" + game.seconds.toString()),
            trailing: Text(
              gameResult,
              style: MyTextStyles.gameResult,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    myTheme = Theme.of(context);

    String exampleDivisionIconLink =
        "https://vignette.wikia.nocookie.net/leagueoflegends/images/d/dc/Season_2019_-_Diamond_3.png/revision/latest/zoom-crop/width/90/height/55?cb=20181229234918";

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
                style: MyTextStyles.queueType,
                children: [
                  TextSpan(
                      text: "$wins/$losses ($ratio%) " + division,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                      )),
                ]),
          ),
          divisionIcon,
        ]),
      );
    }

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
                  style: MyTextStyles.nickname,
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
      color: baseTheme.primaryColor,
      height: 220,
      child: Card(
//        elevation: 5,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Opacity(
              opacity: 0.6,
              child: mostPopularChampImage,
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

//    SliverList(
//      delegate: SliverChildBuilderDelegate(
//            (context, index) => _buildTile(index),
//        childCount: (present <= _games.length)
//            ? items.length + 1
//            : items.length,
//      ),
//    ),

    Widget gamesList = ListView.builder(
      itemBuilder: (context, index) => _buildTile(index),
      itemCount:
//                    _games.length,
          (present <= _games.length) ? items.length + 1 : items.length,
    );

    Widget secondPart = DefaultTabController(
      length: 2,
      child: Container(
        color: myTheme.primaryColor,
        child: Column(children: [
          TabBar(
            labelColor: myTheme.accentColor,
            tabs: <Widget>[
              Tab(
                text: "Match History",
              ),
              Tab(
                text: "Statistics",
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: <Widget>[
                gamesList,
                GameStatsScreen(),
              ],
            ),
          )
        ]),
      ),
    );

//    return FutureBuilder(
//      future:
////      Future.delayed(Duration(seconds: 2)),
//          _fetchNetworkData(
//              "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/Ashe_0.jpg"),
//      // todo
//      builder: (BuildContext context, AsyncSnapshot snapshot) {
//        if (snapshot.connectionState == ConnectionState.done) {
//          log("DONE");

    return Scaffold(
      appBar: AppBars.baseAppBar(context),
      body: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels ==
                scrollInfo.metrics.maxScrollExtent) {
              loadMore();
            }
          },
          child: Column(
            children: <Widget>[
              mainInfoSection,
              Expanded(
                child: secondPart,
              ),
            ],
          )),
    );
  }
}
