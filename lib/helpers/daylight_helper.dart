import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/daylighttimes.dart';
import '../models/place.dart';
import '../shared/global_config.dart';


class DayLightHelper {
  static Future<DayLightTimes> getSunriseSunsetTimes(PlaceLocation loc) async {
    print("daylighthelper : getSunriseSunsetTimes ");

    print(
        "In the _getSunriseSunsetTimes latitude  = ${loc.latitude.toString()}");
    print(
        "In the _getSunriseSunsetTimes longitude  = ${loc.longitude.toString()}");
    final Uri sunrisesunseturi = Uri.https('sun.p.rapidapi.com', '/api/sun/', {
      'latitude': loc.latitude.toString(),
      'longitude': loc.longitude.toString()
    });

    final sunrisesunsetresponse = await http.get(
      sunrisesunseturi.toString(),
      headers: {
        "X-RapidAPI-Key": xrapidapikey
      },
    );

    final sunrisesunsetdecodedResponse =
        json.decode(sunrisesunsetresponse.body);
    print(
        "Sunrisesunset response =    ${sunrisesunsetdecodedResponse.toString()} ");
    final String dawn = sunrisesunsetdecodedResponse[0]['dawn'];
    //final String sunset = sunrisesunsetdecodedResponse["sunset"];
    print("dawn = $dawn");
    final String sunset = sunrisesunsetdecodedResponse[1]['sunset'];
    //final String sunset = sunrisesunsetdecodedResponse["sunset"];
    print("sunset = $sunset");

    final String sunrise = sunrisesunsetdecodedResponse[3]['sunrise'];
    //final String sunset = sunrisesunsetdecodedResponse["sunset"];
    print("sunrise = $sunrise");

    return (DayLightTimes(
        latitude: loc.latitude,
        longitude: loc.longitude,
        sunrise: DateTime.parse(sunrise),
        sunset: DateTime.parse(sunset),
        sunrisestring: sunrise,
        sunsetstring: sunset));
  }
}
