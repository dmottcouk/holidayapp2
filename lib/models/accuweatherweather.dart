import 'package:flutter/material.dart';

class Accuweatherweather {

  final DateTime headlinedate;
  final int headlineseverity;
  final String headlinetext;
  final String headlinecategory;
  final DateTime headlineenddate;
  final DateTime forecastdate;
  final double forecastmintemp;
  final double forecastmaxtemp;
  final int dayiconnumber;
  final String dayiconphrase;
  final bool dayhasprecipitation;
  final String dayprecipitationtype;
  final String dayprecipitationintensity;
  final int nighticonnumber;
  final String nighticonphrase;
  final bool nighthasprecipitation;
  final String nightprecipitationtype;
  final String nightprecipitationintensity;  


Accuweatherweather(
    {@required this.headlinedate,
    @required this.headlineseverity, 
    @required this.headlinetext, 
    @required this.headlinecategory, 
    @required this.headlineenddate,
    @required this.forecastdate,
    @required this.forecastmintemp,
    @required this.forecastmaxtemp,
    @required this.dayiconnumber,
    @required this.dayiconphrase, 
    @required this.dayhasprecipitation,
    @required this.dayprecipitationtype,
    @required this.dayprecipitationintensity,
    @required this.nighticonnumber,
    @required this.nighticonphrase, 
    @required this.nighthasprecipitation,
    @required this.nightprecipitationtype,
    @required this.nightprecipitationintensity,
   });


}