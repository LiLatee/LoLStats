import 'package:flutter/material.dart';

const String SERVER_ADDRESS = "http://192.168.1.68:5000/";
final PageStorageBucket bucket = new PageStorageBucket();

Map<String, dynamic> championsIdsNames;
Map<String, dynamic> perksIdsNames;
Map<String, dynamic> summonersSpellsIdsNames;
String newestPatch;