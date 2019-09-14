import 'package:flutter/material.dart';

class WeatherSourceScreen extends StatelessWidget {
  final Function setWeatherSource;
  final bool currentaccuweatherflag;
  WeatherSourceScreen(this.setWeatherSource, this.currentaccuweatherflag);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather source'),
      ),
      body: SwitchListTile(
        title: (Text('Use accuweather?')),
        value: currentaccuweatherflag,
        subtitle: Text('If false openweather will be used'),
        onChanged: (bool value) {
          setWeatherSource(value);
        },
      ),
    );
  }
}
