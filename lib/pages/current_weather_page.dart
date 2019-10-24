import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/currentweather_provider.dart';
import '../helpers/currentweather_helper.dart';
import '../models/place.dart';
import '../models/currentweather.dart';

class CurrentWeatherPage extends StatelessWidget {
  static const routeName = '/weather';

  final PlaceLocation loc;
  CurrentWeatherPage(this.loc);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Today\'s weather'),
      ),
      body: FutureBuilder(
        future: Provider.of<CurrentWeatherProvider>(context, listen: false)
            .fetchAndSetWeather(loc),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<CurrentWeatherProvider>(
                builder: (ctx, currentweather, ch) =>
                    currentweather.dataReady == false
                        ? Center(child: const Text('No weather info available'))
                        : _weatherBuilder(context, currentweather.theWeather)),
      ),
    );
  }

  Widget _weatherBuilder(BuildContext ctx, CurrentWeather weather) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
                color: Theme.of(ctx).primaryColorLight,
                borderRadius: BorderRadius.circular(10)),
            child: Image.network(
    //            "http://openweathermap.org/img/w/${weather.icon}.png",
                "http://openweathermap.org/img/w/10d.png",
                scale: 0.3),
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
                  SizedBox(height: 10),
                  Text(
                    "Temperature (Celsius): ${weather.temp.toStringAsFixed(2)}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        //color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Weather: ${weather.weathermain}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        //color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Detail: ${weather.weatherdescription}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        //color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Cloud cover (%): ${weather.cloudcover}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        //color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Humidity (%): ${weather.humidity}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        //color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Wind strength (mph): ${weather.windstrength}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        //color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Wind direction: ${CurrentWeatherHelper.getTheWindDirection(weather.winddirection)}",
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

  Widget _WeatherTitle(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(5.0)),
      child: Text('Weather Data', style: TextStyle(color: Colors.white)),
    );
  }
}
