import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/currentaccuweather_provider.dart';
import '../models/place.dart';

class AccuweatherDay extends StatelessWidget {
  final PlaceLocation loc;

  const AccuweatherDay({this.loc});

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
                  : Center(
                      child: const Text('Display day data'),
                    ),
            ),
    );
  }
}
