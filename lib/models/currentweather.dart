import 'package:flutter/material.dart';

class CurrentWeather {
  final String id;     // use uuid
  final num unixstamp;
  final DateTime timestamp; // see above
  final num temp;  
  final num pressure;
  final num humidity;
  final String weathermain;
  final String weatherdescription;
  final String icon;
  final num cloudcover;
  final num windstrength;
  final num winddirection; // can be null
  final double rain;        // can be null
  final double snow;    // can be null

  // remember the { } makes them named parameters

  CurrentWeather(
    {@required this.id,
    @required this.unixstamp, 
    @required this.timestamp, 
    @required this.temp, 
    @required this.pressure,
    @required this.humidity,
    @required this.weathermain,
    @required this.weatherdescription,
    @required this.icon,
    @required this.cloudcover, 
    @required this.windstrength,
    @required this.winddirection,
    this.rain,
    this.snow,
   });

}