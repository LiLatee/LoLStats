
import 'package:flutter/cupertino.dart';

double getWidth({BuildContext context}) => MediaQuery.of(context).size.width;
double getHeight({BuildContext context}) => MediaQuery.of(context).size.height;
double getPercentOfWidth({BuildContext context, double percent}) => MediaQuery.of(context).size.width*percent;
double getPercentOfHeight({BuildContext context, double percent}) => MediaQuery.of(context).size.height*percent;
//double getScaleFactor({BuildContext context}) => (MediaQuery.of(context).size.width*MediaQuery.of(context).devicePixelRatio)/1080;
double getScaleFactor({BuildContext context}) => (MediaQuery.of(context).devicePixelRatio/2.75)*(MediaQuery.of(context).size.width/392)*(700/MediaQuery.of(context).size.height);