import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lolstats/models/KDA.dart';
import 'package:lolstats/common/AppColors.dart' as AppColors;
import 'package:lolstats/common/AppBars.dart' as AppBars;
import 'package:lolstats/models/PlayerGameStats.dart';

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
    asheIcon = NetworkImage('https://gamepedia.cursecdn.com/lolesports_gamepedia_en/4/4a/AsheSquare.png');
    sort = false;
    playersList = [
      PlayerGameStats(KDA(5, 2, 8), 3003, 123134, 345, 123, 999, asheIcon),
      PlayerGameStats(KDA(5, 2, 8), 4000, 123134, 345, 123, 888, asheIcon),
      PlayerGameStats(KDA(5, 2, 8), 222, 123134, 345, 123, 999,  asheIcon),
      PlayerGameStats(KDA(5, 2, 8), 3003, 123134, 345, 123, 444, asheIcon),
      PlayerGameStats(KDA(5, 2, 8), 3003, 123134, 345, 123, 666, asheIcon)
    ];
    super.initState();
  }



  void onSortColumn(int columnIndex, bool ascending, String columnName) {
      if (ascending) {
        playersList.sort((a, b) => a.getAttributeByName(columnName).compareTo(b.getAttributeByName(columnName)));
      } else {
        playersList.sort((a, b) => b.getAttributeByName(columnName).compareTo(a.getAttributeByName(columnName)));
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






    Widget gameStatsTable = Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 2.0,
          columns: [
            DataColumn(
              label: Text(''),
              numeric: false,
            ),
            DataColumn(
              label: Text('Gold Earned'),
              numeric: true,
            ),
            DataColumn(
              label: Text('Vision Score'),
              numeric: true,
            ),
            DataColumn(
              label: Text('Damage Dealt'),
              numeric: true,
            ),
            DataColumn(
              label: Text('Damage Taken'),
              numeric: true,

            ),
            DataColumn(
              label: Text('Damage Healed'),
              numeric: true,
            ),
          ],
          rows: playersList.map((player) =>
              DataRow(
                cells: [
                  DataCell(
                    CircleAvatar(backgroundImage:               NetworkImage(
                        'https://gamepedia.cursecdn.com/lolesports_gamepedia_en/4/4a/AsheSquare.png'), radius: CHAMP_AVATAR_SIZE,),
                  ),
                  DataCell(
                    Text(player.goldEarned.toString()),
                  ),
                  DataCell(
                    Text(player.visionScore.toString()),
                  ),
                  DataCell(
                    Text(player.damageDealt.toString()),
                  ),
                  DataCell(
                    Text(player.damageTaken.toString()),
                  ),
                  DataCell(
                    Text(player.damageHealed.toString()),
                  ),
                ],
              ),).toList(),
        ),
      ),

    );


    return Scaffold(
      appBar: AppBars.baseAppBar(context),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                redTeamTable,
                blueTeamTable,
                gameStatsTable,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
