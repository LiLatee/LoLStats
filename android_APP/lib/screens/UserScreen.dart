import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lolstats/common/themes.dart';
import 'package:lolstats/models/Champion.dart';

import 'package:lolstats/models/KDA.dart';
import 'package:lolstats/models/User.dart';
import 'package:lolstats/screens/GameStatsPlayersTableScreen.dart';
import 'package:lolstats/common/TextStyles.dart' as MyTextStyles;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'package:lolstats/common/util.dart' as util;
import 'package:lolstats/models/Game.dart';

//https://eune.leagueoflegends.com/pl-pl/news/game-updates/patch-10-11-notes/

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

  // TODO:
  Image mostPopularChampImage = util.getChampionSplash("Ashe");

  int perPage = 10;
  int present = 0;

  Future<List<Game>> futureGames;
  Future<User> futureUser;
  List<Game> currentGames = List<Game>();

  Future<User> fetchUser() async {
    final response = await http
        .get(util.SERVER_ADDRESS + 'get_player_profile_info/${userName}');

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);

      User user = User.fromJson(jsonResponse);
      return user;
    } else {
      throw Exception('Failed to load User');
    }
  }

  Future<List<Game>> fetchGames({List<Game> games, bool progressIndicator = false}) async {
    if (games != null) {
        currentGames.addAll(games);
        present = currentGames.length;
        return games;
      }
    final response = await http.get(util.SERVER_ADDRESS +
        'get_player_history_nick/$userName?n_games=$perPage&index_begin=$present');

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);

      List<Game> games = jsonResponse
          .map<Game>((jsonGame) => Game.fromJson(jsonGame))
          .toList();

      if (progressIndicator) {
        currentGames.remove(currentGames[currentGames.length - 1]);
      }
      currentGames.addAll(games);
      present = present + perPage;

      return games;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  ScrollController _controller;

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        if (!(currentGames[currentGames.length - 1].primaryRune == -1) &&
            !(currentGames[currentGames.length - 1].secondRune == -1)) {
          currentGames.add(Game.dummy());
        }
        futureGames = fetchGames(progressIndicator: true);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    futureUser = fetchUser();
    log("beeeeeeee", name: "MOJE_LOGI");
    if (util.bucket.readState(context, identifier: ValueKey(util.mykey)) != null) {
      setState(() {
        List<Game> g = util.bucket.readState(context, identifier: ValueKey(util.mykey));
        futureGames = fetchGames(games: g);
        log(g.length.toString(), name: "MOJE_LOGI");
      });

      log("Hmmmm", name: "MOJE_LOGI");
    }
    else {
      log("EHHHHHHHHH", name: "MOJE_LOGI");
      futureGames = fetchGames();
    }

  }

  void loadMore() {
    setState(() {
      futureGames = fetchGames();
    });
  }
  Widget _buildTile(Game game) {
    const double CHAMP_AVATAR_SIZE = 27.0;
    const double EDGE_INSECTS_IN_TEAMS_INFO = 8.0;

    if (game.primaryRune == -1 && game.secondRune == -1) {
      return Container(
          color: baseTheme.primaryColor,
          alignment: Alignment.center,
          child: CircularProgressIndicator());
    }
    Color color = game.isWin ? Colors.green[400] : Colors.red[400];
    String gameResult = (game.isWin) ? "Win" : "Loss";
    Image image = util.getChampionAvatar("Zed"); //TODO: champion id?

    Widget createRow(
        NetworkImage champIcon, int mainRune, int secondRune, KDA kda) {
      Widget avatarSection = CircleAvatar(
        backgroundImage: image.image,
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
                    child: util.getChampionAvatar("Ezreal"),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: CHAMP_AVATAR_SIZE / 2,
                    child: util.getChampionAvatar("Caitlyn"),
                  ),
                ],
              ),
            ],
          ));

//      Widget nickAndCsSection = Container(
//        padding: EdgeInsets.only(left: EDGE_INSECTS_IN_TEAMS_INFO),
//        child: FittedBox(
//          fit: BoxFit.scaleDown,
//          child: Column(
//            children: <Widget>[
//              Text(
//                playerName,
//                style: TextStyle(
//                  color: Colors.black,
//                  fontWeight: FontWeight.w600,
//                  fontSize: 16.0,
//                ),
//              ),
//              Text("CS: " + 123.toString(), style: TextStyle(fontSize: 12)),
//            ],
//          ),
//        ),
//      );

      Widget durationAndCsSection = Container(
        padding: EdgeInsets.only(left: EDGE_INSECTS_IN_TEAMS_INFO),
        child: Column(
          children: <Widget>[
        Text((game.gameDurationSecs ~/ 60).toString() +
                ":" +
                (game.gameDurationSecs % 60).toString().padLeft(2, '0')),
            FittedBox(
              fit: BoxFit.scaleDown,
              child:
                  Text("CS: " + 123.toString(), style: TextStyle(fontSize: 12)),
            )
          ],
        ),
      );

      String kdaRatio = kda.deaths > 0
          ? util
              .roundDouble(((kda.kills + kda.assists) / kda.deaths), 2)
              .toString()
          : util.roundDouble(((kda.kills + kda.assists) / 1), 2).toString();
      Widget kdaSection = Container(
        padding: EdgeInsets.only(left: EDGE_INSECTS_IN_TEAMS_INFO),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            children: <Widget>[
              Text(kda.toString()),
              Text(kdaRatio.toString(), style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
      );

      Image exampleItem = Image.network(
        'https://vignette.wikia.nocookie.net/leagueoflegends/images/9/9f/Warmog%27s_Armor_item.png/revision/latest?cb=20171222001951',
        width: CHAMP_AVATAR_SIZE,
        height: CHAMP_AVATAR_SIZE,
      );
      Widget emptyItem = Opacity(
        opacity: 0.7,
        child: Container(
          width: CHAMP_AVATAR_SIZE,
          height: CHAMP_AVATAR_SIZE,
          color: Colors.grey,
        ),
      );

      Widget itemsSection = Container(
        padding: EdgeInsets.only(left: EDGE_INSECTS_IN_TEAMS_INFO),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                exampleItem,
                exampleItem,
                exampleItem,
              ],
            ),
            Row(
              children: <Widget>[
                exampleItem,
                exampleItem,
                emptyItem,
              ],
            ),
          ],
        ),
      );

      Widget resultSection = Align(
        alignment: Alignment.centerRight,
        child: Container(
          padding: EdgeInsets.only(right: EDGE_INSECTS_IN_TEAMS_INFO),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              gameResult,
//              style: MyTextStyles.gameResult,
            ),
          ),
        ),
      );

      return Container(
        child: Card(
          margin: EdgeInsets.all(3.0),
          color: color,
          child: Container(
            padding: EdgeInsets.all(2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                avatarSection,
                spellsRunesSection,
                Expanded(flex: 15, child: kdaSection),
                Expanded(flex: 10, child: durationAndCsSection),
                Expanded(flex: 20, child: itemsSection),
                Expanded(flex: 10, child: resultSection),
              ],
            ),
          ),
        ),
      );
    }

    void openMatchStats() {
      setState(() {
        List<Game> temp = List<Game>();
        for (var i=0; i<currentGames.length; i++) {
          if (currentGames[i] != Game.dummy())
            {
              temp.add(currentGames[i]);
            }
        }
        util.bucket.writeState(context, temp,
            identifier: ValueKey(util.mykey));
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => GameStatsPlayersTableScreen(game: game)));
    }
    return GestureDetector(
      onTap: () => openMatchStats(),
      child: createRow(
          NetworkImage(
              'https://gamepedia.cursecdn.com/lolesports_gamepedia_en/4/4a/AsheSquare.png'), //TODO
          100, // TODO
          100, // TODO
          game.kda),
    );

//    return GestureDetector(
//      onTap: () => Navigator.push(
//          context, MaterialPageRoute(builder: (context) => GameStatsScreen())),
//      child: Card(
//        elevation: 5,
//        child: Container(
//          color: color,
//          child: ListTile(
//            leading: image,
//            title: Container(
//              child: Text((game.KDA['kills'].toString() +
//                  '/' +
//                  game.KDA['deaths'].toString() +
//                  '/' +
//                  game.KDA['assists'].toString())),
//            ),
//            subtitle: Text((game.gameDurationSecs ~/ 60).toString() +
//                ":" +
//                (game.gameDurationSecs % 60).toString().padLeft(2, '0')),
//            trailing: Text(
//              gameResult,
//              style: MyTextStyles.gameResult,
//            ),
//          ),
//        ),
//      ),
//    );
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

    Widget getTopRowOfMainInfoSection(User user) => Expanded(
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

    Widget getBotRowOfMainInfoSection(User user) => Expanded(
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
                          user.queuesData[0].tier +
                              " " +
                              user.queuesData[0].rank,
                          exampleDivisionIconLink),
                      getGamesStatsText(
                          "Flex: ",
                          user.queuesData[1].wins,
                          user.queuesData[1].losses,
                          user.queuesData[1].tier +
                              " " +
                              user.queuesData[1].rank,
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
      alignment: Alignment.center,
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
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
    );

    Widget gamesList = Container(
      alignment: Alignment.center,
      child: FutureBuilder<List<Game>>(
        future: futureGames,
        builder: (context, snapshot) {
          if (currentGames.length != 0) {
            return ListView.builder(
              controller: _controller,
              itemBuilder: (context, index) => _buildTile(currentGames[index]),
              itemCount: currentGames.length,
            );
          } else if (snapshot.hasError) {
            return Center(child: Container(child: Text(snapshot.error.toString())));
          } else if (snapshot.connectionState != ConnectionState.done) {
            return CircularProgressIndicator();
          } else if (currentGames.length == 0) {
            return Center(child: Container(child: Text("Empty")));
          }
//          }

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
                Center(child: Text("Soon :)")),
              ],
            ),
          )
        ]),
      ),
    );



    return Column(
      children: <Widget>[
        AspectRatio(
            aspectRatio: 16/9,
            child: mainInfoSection),
        Expanded(
          child: PageStorage(
            key: util.mykey,
              bucket: util.bucket,
              child: secondPart),
        ),
      ],
    );
  }
}
