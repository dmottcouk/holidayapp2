import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/currentaccuweather_provider.dart';
import '../models/place.dart';
import '../models/accuweatherweather.dart';

class AccuweatherNight extends StatelessWidget {
  final PlaceLocation loc;

  const AccuweatherNight({this.loc});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<CurrentAccuweatherProvider>(context, listen: false)
          .fetchAndSetAccuWeather(loc),
      builder: (ctx, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Consumer<CurrentAccuweatherProvider>(
              builder: (ctx, currentweather, ch) => currentweather.dataReady ==
                      false
                  ? Center(child: const Text('No accuweather info available'))
                  : _buildAccuweatherNight(context, currentweather.theWeather)),
    );
  }
}

Widget _buildAccuweatherNight(BuildContext ctx, Accuweatherweather weather) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Expanded(
        flex: 2,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(10)),
          child: Image.asset(
            'assets/images/accuweather/accuweathericon${weather.nighticonnumber}.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
      //SizedBox(height: 10),
      //Text(
      //  "Weather Data",
      //  style: TextStyle(fontSize: 14, color: Colors.red),
      //),
      //_WeatherTitle(context),
      Expanded(
        flex: 5,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: BoxDecoration(
              color: Colors.lightGreen,
              borderRadius: BorderRadius.circular(10)),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Headline: ${weather.headlinetext}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      //color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "Date: ${weather.forecastdate}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      //color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "Min temp (Celsius): ${weather.forecastmintemp.toStringAsFixed(2)}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      //color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "Max temp (Celsius): ${weather.forecastmaxtemp.toStringAsFixed(2)}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      //color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "Precipitation: ${weather.nighthasprecipitation.toString()}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      //color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "Icon desc: ${weather.nighticonphrase}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      //color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
