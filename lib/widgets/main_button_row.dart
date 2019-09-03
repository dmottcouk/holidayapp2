import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../providers/currenttrafficsettings_provider.dart';
import '../pages/current_weather_page.dart';
import '../pages/current_tides_page.dart';
import '../pages/current_traffic_page.dart';
import '../models/place.dart';

class MainButtonRow extends StatelessWidget {
  PlaceLocation loc;
  MainButtonRow(this.loc);

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
                  builder: (BuildContext context) => CurrentTrafficPage(
                      loc, trafficsettings.thetrafficsettings),
                ),
              ),
        ),
        RaisedButton(
          shape: const StadiumBorder(),
          child: Text('Tides'),
          color: Theme.of(context).primaryColorLight,
          //onPressed: () {},

          onPressed: () => Navigator.of(context).pushNamed(CurrentTidesPage.routeName)
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
                Navigator.of(context).pushNamed(CurrentWeatherPage.routeName)
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
