import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lolstats/common/themes.dart';
import 'package:lolstats/models/Champion.dart';

import 'package:lolstats/models/Game.dart';
import 'package:lolstats/models/KDA.dart';
import 'package:lolstats/models/User.dart';
import 'package:lolstats/screens/GameStatsScreen.dart';
import 'package:lolstats/common/TextStyles.dart' as MyTextStyles;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'package:lolstats/common/util.dart' as util;

class UserScreen extends StatefulWidget {
  final String userName;

  UserScreen({Key key, @required this.userName}) : super(key: key);

  @override
  _UserScreen createState() => _UserScreen(userName: userName);
}

class _UserScreen extends State<UserScreen> {
  _UserScreen({@required this.userName});

  final String userName;

  ThemeData myTheme;

  int normalWins = 300;
  int normalLosses = 350;

  Image mostPopularChampImage = util.getChampionSplash("Ashe");

  int perPage = 10;
  int present = 0;

  Future<List<Album>> futureGames;
  Future<User> futureUser;
  List<Album> currentGames = List<Album>();

  Future<User> fetchUser() async {
    final response = await http
        .get('http://192.168.1.68:5000/get_player_profile_info/${userName}');


    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);

      User user = User.fromJson(jsonResponse);
      return user;
    } else {
      throw Exception('Failed to load User');
    }
  }

  Future<List<Album>> fetchGames() async {
    final response = await http.get('http://192.168.1.68:5000/');

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      List<Album> games = jsonResponse
          .map<Album>((jsonAlbum) => Album.fromJson(jsonAlbum))
          .toList();
//      log("TERAZ", name: "MOJE_LOGI");
//      log(present.toString(), name: "MOJE_LOGI");
//      log((present + perPage).toString(), name: "MOJE_LOGI");

      currentGames.addAll(games.getRange(present, present + perPage));
      log(currentGames.length.toString(), name: "MOJE_LOGI");
      present = present + perPage;

      return games;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      futureGames = fetchGames();
      futureUser = fetchUser();
    });
  }

  void loadMore() {
    setState(() {
      futureGames = fetchGames();
    });
  }

  Widget _buildTile(Album game) {
    bool isWin = true;
    Color color = isWin ? Colors.green[400] : Colors.red[400];
    String gameResult = (isWin) ? "Win" : "Lose";
    Image image = util.getChampionAvatar("Zed");

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
      onTap: () =>
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GameStatsScreen())),
      child: Card(
        elevation: 5,
        child: Container(
          color: color,
          child: ListTile(
            leading: image,
            title: Text(game.name.toString()),
            subtitle:
            Text(game.lastname.toString() + ":" + game.lastname.toString()),
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

    // TODO: wczytywanie ikony dywizji
    String exampleDivisionIconLink =
        "https://vignette.wikia.nocookie.net/leagueoflegends/images/d/dc/Season_2019_-_Diamond_3.png/revision/latest/zoom-crop/width/90/height/55?cb=20181229234918";

    Widget getGamesStatsText(String queueType, int wins, int losses,
        [String division = "", exampleDivisionIconLink = null]) {
      double ratio = util.roundDouble(wins / (wins + losses) * 100, 2);

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

    Widget getTopRowOfMainInfoSection(User user) =>
        Expanded(
          flex: 1,
          child: Row(
            children: <Widget>[
              Container(
                width: 100,
                height: 100,
                margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: util.getProfileIcon(user.profileIconId.toString()),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Text(
                      user.name,
                      softWrap: true,
                      style: MyTextStyles.nickname,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );

    Widget getBotRowOfMainInfoSection(User user) =>
        Expanded(
          flex: 1,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      getGamesStatsText(
                          "Solo/Duo: ",
                          user.queuesData[0].wins,
                          user.queuesData[0].losses,
                          // TODO: zastąpić 0 przez SOLO/DUO itd.
                          user.queuesData[0].tier + " " + user.queuesData[0].rank,
                          exampleDivisionIconLink),
                      getGamesStatsText(
                          "Flex: ",
                          user.queuesData[1].wins,
                          user.queuesData[1].losses,
                          user.queuesData[1].tier + " " + user.queuesData[1].rank,
                          exampleDivisionIconLink),
                      getGamesStatsText(
                          "Normal: ", normalWins, normalLosses, "", null),
                      // TODO: normali nie ma w danych
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
      child: FutureBuilder<User>(
        future: futureUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Card(
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
                        getTopRowOfMainInfoSection(snapshot.data),
                        getBotRowOfMainInfoSection(snapshot.data),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
    );

    Widget gamesList = Container(
      child: FutureBuilder<List<Album>>(
        future: futureGames,
        builder: (context, snapshot) {
          if (currentGames.length != 0) {
            return ListView.builder(
              itemBuilder: (context, index) => _buildTile(currentGames[index]),
              itemCount: currentGames.length,
            );
          } else if (currentGames.length == 0) {
            return Center(child: Container(child: Text("Empty")));
          } else if (snapshot.hasError) {
            return Center(child: Container(child: Text("Network Error")));
          }

          return Center(child: Container(child: Text("unexpected")));
//          else {
//            if (currentGames.length != 0) {
//              return ListView.builder(
//                itemBuilder: (context, index) =>
//                    _buildTile2(currentGames[index]),
//                itemCount:
//                currentGames.length,
////                  (present <= _games.length) ? items.length + 1 : items.length,
//              );
//            }
//          };
        },
      ),
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

    return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
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
        ));
  }
}

class Album {
  final String name;
  final String lastname;

  Album({this.name, this.lastname});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(name: json['name'], lastname: json['lastname']);
  }
}
