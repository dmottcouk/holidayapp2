import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/currentweather.dart';
import '../models/place.dart';
import '../shared/global_config.dart';

class CurrentWeatherHelper {
  static Future<CurrentWeather> getCurrentWeather(PlaceLocation loc) async {
    print("CurrentWeatherHelper: getCurrentWeather: Trying to get the weather");
    print("CurrentWeatherHelper:Latitude = ${loc.latitude}");
    print("CurrentWeatherHelper:Longitude = ${loc.longitude}");
    try {
      final Uri weatheruri =
          Uri.http('api.openweathermap.org', '/data/2.5/forecast', {
        'lat': loc.latitude.toString(),
        'lon': loc.longitude.toString(),

        'appid': openweatherapiKey,
        'units': 'imperial'
      });
      final http.Response weatherresponse = await http.get(weatheruri);
      print('Got the weatherresponse');
      final weatherdecodedResponse = json.decode(weatherresponse.body);
      print('decode = $weatherdecodedResponse');
      final code = weatherdecodedResponse['cod'];
      print("cod = $code");
      final dateunixtime = weatherdecodedResponse['list'][0]['dt'];
      print("unixstamp = $dateunixtime");

      // you can get the icon to show from url http://openweathermap.org/img/w/" + iconcode + ".png";
      // using the text returned in icon

      //final coords = decodedResponse['results'][0]['geometry']['location'];
      final date = new DateTime.fromMillisecondsSinceEpoch(dateunixtime * 1000);
      print("date = ${date.toIso8601String()}");

      final double temp =
          ((weatherdecodedResponse['list'][0]['main']['temp_min'] - 32) * 5) /
              9;
      print("temp = $temp");

      final num humidity =
          weatherdecodedResponse['list'][0]['main']['humidity'];
      print("humidity = $humidity");
      final weathermain =
          weatherdecodedResponse['list'][0]['weather'][0]['main'];
      final weatherdescription =
          weatherdecodedResponse['list'][0]['weather'][0]['description'];

      print("weathermain = $weathermain");
      print("weatherdescription = $weatherdescription");

      final double pressure = 0.1;
      //    weatherdecodedResponse['list'][0]['main']['pressure'];
     // print("pressure = $pressure");


      final num cloudcover = weatherdecodedResponse['list'][0]['clouds']['all'];
      print("cloudcover = $cloudcover");
      final windstrength = weatherdecodedResponse['list'][0]['wind']['speed'];
      print("windstrength = $windstrength");

      final winddirection = weatherdecodedResponse['list'][0]['wind']['deg'];
      print("winddirection = $winddirection");
      print("timestamp = $date");
      final weathericon =
          weatherdecodedResponse['list'][0]['weather'][0]['icon'];
      print("weathericon = $weathericon");

      return (CurrentWeather(
          id: DateTime.now().toString(),
          unixstamp: dateunixtime,
          timestamp: date,
          temp: temp,
          pressure: pressure,
          humidity: humidity,
          weathermain: weathermain,
          weatherdescription: weatherdescription,
          icon: weathericon,
          cloudcover: cloudcover,
          windstrength: windstrength,
          winddirection: winddirection));
    } catch (error) {
      print('Error in getting weather');
    } finally {}
  }

  static String getTheWindDirection(double windDirection) {
    if ((windDirection > 348.75) || (windDirection < 11.25)) return 'N';
    if ((windDirection >= 11.25) && (windDirection < 33.75)) return 'NNE';
    if ((windDirection >= 33.75) && (windDirection < 56.25)) return 'NE';
    if ((windDirection >= 56.25) && (windDirection < 78.75)) return 'ENE';
    if ((windDirection >= 78.75) && (windDirection < 101.25)) return 'E';
    if ((windDirection >= 101.25) && (windDirection < 123.75)) return 'ESE';
    if ((windDirection >= 123.75) && (windDirection < 146.25)) return 'SE';
    if ((windDirection >= 146.25) && (windDirection < 168.75)) return 'SSE';
    if ((windDirection >= 168.75) && (windDirection < 191.25)) return 'S';
    if ((windDirection >= 191.25) && (windDirection < 213.75)) return 'SSW';
    if ((windDirection >= 213.75) && (windDirection < 236.25)) return 'SW';
    if ((windDirection >= 236.25) && (windDirection < 258.75)) return 'WSW';
    if ((windDirection >= 258.75) && (windDirection < 281.25)) return 'W';
    if ((windDirection >= 281.25) && (windDirection < 303.75)) return 'WNW';
    if ((windDirection >= 303.75) && (windDirection < 326.25)) return 'NW';
    if ((windDirection >= 326.25) && (windDirection <= 348.75)) return 'NNW';
  }
}
