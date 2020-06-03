import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lolstats/common/AppBars.dart' as AppBars;
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatefulWidget{

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  ThemeData myTheme;

  @override
  Widget build(BuildContext context) {
    myTheme = Theme.of(context);

    return Scaffold(
      appBar: AppBars.baseAppBar(context),
      body:
        Center(child:
        WebView(
          initialUrl: "https://eune.leagueoflegends.com/pl-pl/news/game-updates/patch-10-11-notes/" ,
        )),
    );
  }
}


class Album {
  final String name;
  final String lastname;

  Album({this.name, this.lastname});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      name: json['name'],
      lastname: json['lastname']
    );
  }
}