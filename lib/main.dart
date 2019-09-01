import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/daylighttimes_provider.dart';
import './providers/currentweather_provider.dart';
import './providers/currenttides_provider.dart';
import './providers/currenttrafficsettings_provider.dart';
import './providers/currenttrafficevents_provider.dart';

import './pages/map_screen.dart';
import './pages/current_weather_page.dart';
import './pages/traffic_filters_screen.dart';
import './pages/current_traffic_page.dart';
import './models/place.dart';
import './widgets/location_static_map.dart';
import './widgets/main_button_row.dart';
import './widgets/main_showdaylighttimes.dart';
import './widgets/main_fab.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PlaceLocation _currentLocation;
  void _selectedPlace(double lat, double lng) {
    setState(() {
      _currentLocation = PlaceLocation(latitude: lat, longitude: lng);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: DayLightTimesProvider(),
        ),
        ChangeNotifierProvider.value(
          value: CurrentWeatherProvider(),
        ),
        ChangeNotifierProvider.value(
          //value: GreatPlaces(),
          value: CurrentTidesProvider(),
        ),
        ChangeNotifierProvider.value(
          //value: GreatPlaces(),
          value: CurrentTrafficSettingsProvider(),
        ),
        ChangeNotifierProvider.value(
          //value: GreatPlaces(),
          value: CurrentTrafficEventsProvider(),
        )
      ],
      child: MaterialApp(
          title: 'Holiday App 2',
          theme: ThemeData(
            primarySwatch: Colors.green,
            accentColor: Colors.deepPurple,
          ),
          // home: PlacesListScreen(),
          home: Builder(
            builder: (context) => Scaffold(
                  appBar: AppBar(
                    title: Text('Holiday App 2'),
                    actions: <Widget>[
                      IconButton(
                          icon: Icon(Icons.settings),
                          onPressed: () => Navigator.of(context)
                              .pushNamed(TrafficFiltersScreen.routeName))
                      //_appBarSettings(context),
                    ],
                  ),
                  body: Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          // call the LocationStaticMap and set the current location by passing the pointer to the _selectedPlace function
                          child: LocationStaticMap(_selectedPlace),
                          //child: Text('Why not working'),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              MainButtonRow(_currentLocation),
                              _currentLocation == null
                                  ? Center(child: CircularProgressIndicator())
                                  : MainShowDayLightTimes(_currentLocation),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  floatingActionButton: MainFab(_currentLocation),
                ),
          ),
          // routes takes a builder
          routes: {
            //move main_page stuff in here to use these

            MapScreen.routeName: (ctx) => MapScreen(),

            TrafficFiltersScreen.routeName: (ctx) => TrafficFiltersScreen(),
            //CurrentWeatherPage.routeName: (ctx) => CurrentWeatherPage(),
            //CurrentTrafficPage.routeName: (ctx) => CurrentWeatherPage(),
          }),
    );
  }
}
