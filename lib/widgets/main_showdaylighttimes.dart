import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/place.dart';
import '../models/daylighttimes.dart';

import '../providers/daylighttimes_provider.dart';

class MainShowDayLightTimes extends StatelessWidget {
  final PlaceLocation loc;

  MainShowDayLightTimes(this.loc);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<DayLightTimesProvider>(context, listen: false)
          .fetchAndSetDaylightTimes(loc),
      builder: (ctx, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Consumer<DayLightTimesProvider>(
              builder: (ctx, daylighttimes, ch) => daylighttimes.dataReady ==
                      false
                  ? Center(child: const Text('No daylight info available'))
                  : _daylighttimesbuilder(daylighttimes.todaysDayLightTimes)),
    );
  }
}

Widget _daylighttimesbuilder(DayLightTimes daylighttimes) {
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          daylighttimes.sunrisestring.contains('+01:00')
              ? "Sunrise Time : ${(daylighttimes.sunrisestring.split('T')[1]).split('+')[0]} BST"
              : "Sunrise Time : ${(daylighttimes.sunrisestring.split('T')[1]).split('+')[0]} GMT",
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        Text(
          daylighttimes.sunsetstring.contains('+01:00')
              ? "Sunset Time : ${(daylighttimes.sunsetstring.split('T')[1]).split('+')[0]} BST"
              : "Sunset Time : ${(daylighttimes.sunsetstring.split('T')[1]).split('+')[0]} GMT",
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
