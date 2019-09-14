import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import './providers/daylighttimes_provider.dart';
import './providers/currentweather_provider.dart';
import './providers/currenttides_provider.dart';
import './providers/currenttrafficsettings_provider.dart';
import './providers/currenttrafficevents_provider.dart';
import './providers/currentaccuweather_provider.dart';

import './pages/map_screen.dart';
import './pages/current_weather_page.dart';
import './pages/traffic_filters_screen.dart';
import './pages/current_tides_page.dart';
import './pages/current_traffic_page.dart';
import './pages/traffic_detail_map_page.dart';
import './pages/weather_source_screen.dart';
import './models/place.dart';
import './widgets/location_static_map.dart';
import './widgets/main_button_row.dart';
import './widgets/main_showdaylighttimes.dart';
import './widgets/main_fab.dart';
import './pages/current_accuweather_page.dart';

enum SettingsOptions {
  Traffic,
  Weather,
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PlaceLocation _currentLocation;
  var accuweathersource = false;

  void _selectedPlace(double lat, double lng) {
    setState(() {
      _currentLocation = PlaceLocation(latitude: lat, longitude: lng);
    });
  }

  void _selectedWeatherSource(bool accu) {
    setState(() {
      accuweathersource = accu;
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
        ),
        ChangeNotifierProvider.value(
          value: CurrentAccuweatherProvider(),
        ),
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
                /*
                actions: <Widget>[
                  IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () => Navigator.of(context)
                          .pushNamed(TrafficFiltersScreen.routeName))
                  //_appBarSettings(context),
                  */
                actions: <Widget>[
                  PopupMenuButton(
                    onSelected: (SettingsOptions selectedValue) {
                      //print('Selected value $selectedValue');
                      setState(() {
                        if (selectedValue == SettingsOptions.Traffic) {
                          Navigator.of(context)
                              .pushNamed(TrafficFiltersScreen.routeName);
                          // _showOnlyFavorites = true;
                          //Consumer
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  WeatherSourceScreen(_selectedWeatherSource,
                                      accuweathersource),
                            ),
                          );

                          // _showOnlyFavorites = false;
                        }
                      });
                    },
                    icon: Icon(
                      Icons.more_vert,
                    ),
                    itemBuilder: (_) => [
                      PopupMenuItem(
                          child: Text('Traffic settings'),
                          value: SettingsOptions.Traffic),
                      PopupMenuItem(
                        child: Text('Weather settings'),
                        value: SettingsOptions.Weather,
                      ),
                    ],
                  ),
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
                          MainButtonRow(_currentLocation, accuweathersource),
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
            //TrafficDetailMapPage.routeName: (ctx) => TrafficDetailMapPage(),

            TrafficFiltersScreen.routeName: (ctx) => TrafficFiltersScreen(),
            CurrentWeatherPage.routeName: (ctx) =>
                CurrentWeatherPage(_currentLocation),
            CurrentTidesPage.routeName: (ctx) =>
                CurrentTidesPage(_currentLocation),
            CurrentAccuweatherPage.routeName: (ctx) =>
                CurrentAccuweatherPage(_currentLocation),
          }),
    );
  }
}
