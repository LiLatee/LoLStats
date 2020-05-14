import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lolstats/models/KDA.dart';
import 'package:lolstats/common/AppColors.dart' as AppColors;
import 'package:lolstats/common/AppBars.dart' as AppBars;

class GameStatsScreen extends StatefulWidget {
  @override
  _GameStatsScreenState createState() => _GameStatsScreenState();
}

class _GameStatsScreenState extends State<GameStatsScreen> {
  @override
  Widget build(BuildContext context) {
    const double CHAMP_AVATAR_SIZE = 18.0;
    const double EDGE_INSECTS_IN_TEAMS_INFO = 8.0;

    Widget createTeamTable() {
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

      return Scaffold(
        appBar: AppBars.baseAppBar(context),
        body: Column(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  redTeamTable,
                  blueTeamTable,
                ],
              ),
            ),
          ],
        ),
      );
    }

    return createTeamTable();
  }
}
