import 'package:flutter/material.dart';
import 'package:lolstats/screens/UserScreen.dart';
import '../common/themes.dart';

AppBar baseAppBar(BuildContext context) {
    return AppBar(
      title: Text("LolStats"),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: IconButton(
            tooltip: "Search anything",
            icon: Icon(Icons.search, size: 26.0),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
          ),
        ),
      ],
    );
  }



  SliverAppBar baseSliverAppBar(BuildContext context) {
    return SliverAppBar(
      title: Text("LolStats"),
      pinned: true,
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: IconButton(
            tooltip: "Search anything",
            icon: Icon(Icons.search, size: 26.0),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
          ),
        ),
      ],
    );
  }


class CustomSearchDelegate extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return baseTheme;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Search term must be longer than two letters.",
            ),
          )
        ],
      );
    }
    return UserScreen(userName: query);

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // This method is called everytime the search term changes.
    // If you want to add search suggestions as the user enters their search term, this is the place to do that.
    return Column();
  }
}
