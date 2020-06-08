import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lolstats/common/AppBars.dart' as AppBars;
import 'package:http/http.dart' as http;
import 'package:lolstats/screens/GraphStats.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:lolstats/common/ConstData.dart' as ConstData;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  ThemeData myTheme;

  Future<void> _downloadConstData() async {
    var response =
        await http.get(ConstData.SERVER_ADDRESS + 'get_champions_ids/');
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      ConstData.championsIdsNames = jsonResponse;
    } else {
      throw Exception('Failed to load ChampionsIdsNames');
    }

    response = await http.get(ConstData.SERVER_ADDRESS + 'get_perks_ids/');
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      ConstData.perksIdsNames = jsonResponse;
    } else {
      throw Exception('Failed to load PerksIdsNames');
    }

    response =
        await http.get(ConstData.SERVER_ADDRESS + 'get_summoners_spells_ids/');
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      ConstData.summonersSpellsIdsNames = jsonResponse;
    } else {
      throw Exception('Failed to load SummonersSpellsIdsNames');
    }

    response = await http.get(ConstData.SERVER_ADDRESS + 'get_newest_patch/');
    if (response.statusCode == 200) {
      ConstData.newestPatch = response.body;
    } else {
      throw Exception('Failed to load NewestPatch');
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    myTheme = Theme.of(context);

    _downloadConstData();


    return Scaffold(
      appBar: AppBars.baseAppBar(context),
      body: Center(
          child: WebView(
        initialUrl:
            "https://eune.leagueoflegends.com/pl-pl/news/game-updates/patch-10-11-notes/",
      )),
    );
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
