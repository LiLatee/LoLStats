import 'package:flutter/material.dart';
import 'package:lolstats/common/themes.dart';
import 'package:flutter/widgets.dart';

Widget getNewSectionText(BuildContext context, String sectionName) {
  return Container(
    color: baseTheme.primaryColor,
    padding: EdgeInsets.all(8.0),
    child: Text(
      sectionName,
      style: Theme.of(context).textTheme.headline2),
  );
}

Widget getEmtpyItem(BuildContext context) {
  return Opacity(
    opacity: 0.7,
    child: Container(color: Colors.grey),
  );
}