import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../providers/currenttrafficsettings_provider.dart';
import '../pages/current_accuweather_page.dart';
import '../pages/current_weather_page.dart';
import '../pages/current_tides_page.dart';
import '../pages/current_traffic_page.dart';
import '../models/place.dart';

class MainButtonRow extends StatelessWidget {
  final PlaceLocation loc;
  final bool useaccuweather;
  MainButtonRow(this.loc, this.useaccuweather);

  @override
  Widget build(BuildContext context) {
    final trafficsettings =
        Provider.of<CurrentTrafficSettingsProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        RaisedButton(
          shape: const StadiumBorder(),
          child: Text('Traffic'),
          color: Theme.of(context).primaryColorLight,
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  CurrentTrafficPage(loc, trafficsettings.thetrafficsettings),
            ),
          ),
        ),
        RaisedButton(
            shape: const StadiumBorder(),
            child: Text('Tides'),
            color: Theme.of(context).primaryColorLight,
            //onPressed: () {},

            onPressed: () =>
                Navigator.of(context).pushNamed(CurrentTidesPage.routeName)
            //context,
            //MaterialPageRoute(
            //  builder: (BuildContext context) => CurrentTidesPage(loc),
            // ),
            //),
            ),
        RaisedButton(
            shape: const StadiumBorder(),
            child: Text('Weather'),
            color: Theme.of(context).primaryColorLight,
            onPressed: () =>
                //Navigator.of(context).pushNamed(CurrentWeatherPage.routeName)
                useaccuweather
                    ? Navigator.of(context)
                        .pushNamed(CurrentAccuweatherPage.routeName)
                    : Navigator.of(context)
                        .pushNamed(CurrentWeatherPage.routeName)
            //context,
            //MaterialPageRoute(
            //  builder: (BuildContext context) => CurrentWeatherPage(loc),
            //),
            //),
            ),
      ],
    );
  }
}
