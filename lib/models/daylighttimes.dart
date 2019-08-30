import 'package:flutter/material.dart';

class DayLightTimes {
  final double latitude;
  final double longitude;
  final String sunrisestring;
  final String sunsetstring;
  final DateTime sunrise;
  final DateTime sunset;

  const DayLightTimes({@required this.latitude, @required this.longitude, @required this.sunrisestring, @required this.sunsetstring, @required this.sunrise, @required this.sunset});

  
}