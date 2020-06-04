import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lolstats/common/AppBars.dart' as AppBars;
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:lolstats/common/ConstData.dart' as ConstData;
import 'package:lolstats/common/DeviceSizes.dart' as DeviceSizes;
import 'package:lolstats/common/util.dart' as util;
import 'dart:math';

class GraphStats extends StatelessWidget {
  final List<int> values;
  final List<int> champsIds;
  final int currentUserIndex;
  int maxValue;

  GraphStats({this.values, this.champsIds, this.currentUserIndex}) {
    this.maxValue = values.reduce(max);
  }

  @override
  Widget build(BuildContext context) {
    Widget getIcon({String champName, Color color}) {
      return CircleAvatar(
        backgroundColor: color,
        radius: DeviceSizes.getPercentOfWidth(context: context, percent: 0.055),
        child: CircleAvatar(
          backgroundImage: util.getChampionAvatar(champName).image,
          radius:
              DeviceSizes.getPercentOfWidth(context: context, percent: 0.05),
        ),
      );
    }

    Widget getValueText({int value}) {
      return Container(
        padding: EdgeInsets.only(left: 5),
        child: Text(
          value.toString(),
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    Widget getBar({int value}) {
      return Container(
        margin: EdgeInsets.only(left: 5),
        color: Colors.blue,
        height: 5,
        width: DeviceSizes.getPercentOfWidth(
            context: context, percent: 0.8 * value / maxValue),
      );
    }

    Widget createRow({int value, int champID, int playerIndex}) {
      Color color = playerIndex < 5 ? Colors.blue : Colors.red;
      if (playerIndex == currentUserIndex ) { color = Colors.amberAccent;}
      
      return Container(
        margin: EdgeInsets.only(top: 5, bottom: 5),
        width: DeviceSizes.getWidth(context: context),
        height: DeviceSizes.getPercentOfWidth(context: context, percent: 0.11),
        child: Row(
          children: <Widget>[
            getIcon(champName: ConstData.championsIdsNames[champID.toString()], color: color),
            Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                getValueText(value: value),
                getBar(value: value),
              ],
            ),
          ],
        ),
      );
    }

    List<Widget> createListOfRows() {
      List<Widget> result = List<Widget>();
      for (var i=0; i<values.length; i++) {
        result.add(createRow(value: values[i], champID: champsIds[i], playerIndex: i));
      }
      return result;
    }
    return Column(
      children: createListOfRows(),
    );
  }
}
