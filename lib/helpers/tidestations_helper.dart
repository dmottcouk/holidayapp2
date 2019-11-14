import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:latlong/latlong.dart';

import '../models/place.dart';
import '../models/tidalstation.dart';
import '../models/tidepoint3.dart';

class TidestationsHelper {
  static Future<List<TidalStation>> _fetchTideStations() async {
    List<TidalStation> _tidalStations = [];
    try {
      http.Response response = await http.get(
          'https://admiraltyapi.azure-api.net/uktidalapi/api/V1/Stations',
          headers: {
            'Ocp-Apim-Subscription-Key': '846897c114fb4bf385a9e40773e6836f'
          });

      final Map<String, dynamic> tidalStationListData =
          json.decode(response.body);
      print('TidestationsHelper: fetch stations response code is ' +
          response.statusCode.toString());
      print(
          'TidestationsHelper: fts:  type is  = ${tidalStationListData["type"]}');
      print(
          'TidestationsHelper: fts: long 0  is   ${tidalStationListData["features"][0]['geometry']['coordinates'][0].toString()}');
      print(
          'TidestationsHelper: fts: lat 0  is   ${tidalStationListData["features"][0]['geometry']['coordinates'][1].toString()}');
      print(
          'TidestationsHelper: fts: id 0  is   ${tidalStationListData["features"][0]["properties"]['Id']}');
      print(
          'TidestationsHelper: fts: name 0  is   ${tidalStationListData["features"][0]["properties"]['Name']}');
      print(
          'TidestationsHelper: fts: country 0  is   ${tidalStationListData["features"][0]["properties"]['Country']}');
      int counter = 0;
      for (counter = 0; counter < 607; counter++) {
        print('TidestationsHelper: fts:Doing the for loop');
        print(
            'TidestationsHelper: fts: country  is ${tidalStationListData["features"][counter]["properties"]['Country']}');
        var _country =
            tidalStationListData["features"][counter]["properties"]['Country'];
        var _name =
            tidalStationListData["features"][counter]["properties"]['Name'];
        print('TidestationsHelper: fts: $_name');

        var _id = tidalStationListData["features"][counter]["properties"]['Id'];
        double _long = tidalStationListData["features"][counter]['geometry']
            ['coordinates'][0];
        double _lat = tidalStationListData["features"][counter]['geometry']
            ['coordinates'][1];
        final newStation = TidalStation(
            country: _country,
            name: _name,
            id: _id,
            longitude: _long,
            latitude: _lat);
        _tidalStations.add(newStation);
      }
    } catch (error) {
      print('TidestationsHelper: fts Admiralty API get stations has failed');
    }
    return _tidalStations;
  }

  static Future<TidalStation> getNearestTideStationToLocation(
      PlaceLocation loc) async {
    List<TidalStation> _tidalStations = [];
    TidalStation _nearestStation;
    num _tempDistance;
    num _tideDistanceFromCurrentLocation;

    _tidalStations = await _fetchTideStations();
    if ((_tidalStations == null) || (_tidalStations.length == 0)) return null;

    Distance distance = new Distance();

    _nearestStation = _tidalStations[0];

    _tideDistanceFromCurrentLocation = distance(
      new LatLng(_nearestStation.latitude, _nearestStation.longitude),
      new LatLng(loc.latitude, loc.longitude),
    );

    print(
        'TidestationsHelper: gntstl: tidal station 0 distance from curr location is $_tideDistanceFromCurrentLocation');

    _tidalStations.forEach((station) {
      _tempDistance = distance(
        new LatLng(station.latitude, station.longitude),
        new LatLng(loc.latitude, loc.longitude),
      );
      if (_tempDistance < _tideDistanceFromCurrentLocation) {
        print(
            'TidestationsHelper: gntstl: Changing localStation dist = ${station.name}');
        print('TidestationsHelper: gntstl: dist = $_tempDistance');
        _tideDistanceFromCurrentLocation = _tempDistance;
        _nearestStation = station;
      }
    });

    print(
        'TidestationsHelper: gntstl: final local station = ${_nearestStation.name}');
    print(
        'TidestationsHelper: gntstl: final local station id = ${_nearestStation.id}');

    return _nearestStation;
  }

  static Future<List<TidePoint3>> getTideInformation(PlaceLocation loc) async {
    List<TidePoint3> _localTidePoints = [];
    print(
        'TidestationsHelper: gti: Get nearest tides to lat:${loc.latitude} , long:${loc.longitude}');

    TidalStation _nearestStation = await getNearestTideStationToLocation(loc);
    print(
        "TidestationsHelper: gti: The id of the tidestation = ${_nearestStation.id}");

    try {
      final response = await http.get(
          'https://admiraltyapi.azure-api.net/uktidalapi/api/V1/Stations/' +
              _nearestStation.id +
              '/TidalEvents',
          headers: {
            'Ocp-Apim-Subscription-Key': '846897c114fb4bf385a9e40773e6836f'
          });
      //final Map<String, dynamic> tidalStationListData =
      //    json.decode(response.body);

      final List<dynamic> tidalStationListData = json.decode(response.body);
      print(
          'TidestationsHelper: gti: fetch tide information response code is ' +
              response.statusCode.toString());
      print(
          'TidestationsHelper: gti: number of tidepoints is ${tidalStationListData.length}');
      print(tidalStationListData[0]);
      print(
          'TidestationsHelper: gti: eventype 0 is ${tidalStationListData[0]["EventType"]}');
      print(
          'TidestationsHelper: gti: Date 0 is ${tidalStationListData[0]["DateTime"]}');
      print(
          'TidestationsHelper: gti: Height 0 is ${tidalStationListData[0]["Height"]}');

      print(
          'TidestationsHelper: gti: eventype 1 is ${tidalStationListData[1]["EventType"]}');
      print(
          'TidestationsHelper: gti: Date 1 is ${tidalStationListData[1]["DateTime"]}');
      print(
          'TidestationsHelper: gti: Height 1 is ${tidalStationListData[1]["Height"] ?? "not given"}');
      final PlaceLocation tidestationLocation = PlaceLocation(latitude:_nearestStation.latitude, longitude: _nearestStation.longitude, address: '${ _nearestStation.name},${ _nearestStation.country}' );

      tidalStationListData.forEach((station) {
        //print('foreach eventype  is ${station["EventType"]}');
        _localTidePoints.add(new TidePoint3(
            id: DateTime.now().toString(),
            loc: tidestationLocation,
            eventtype: station["EventType"],
            datestamp: station["DateTime"],
            height: station["Height"] ?? -1.0));
      });

      var counter = 0;
      _localTidePoints.forEach((tidepoint) {
        print('TidestationsHelper: gti eventype $counter is ${tidepoint.eventtype}');
        print('TidestationsHelper: gti datetime $counter is ${tidepoint.datestamp}');
        print('TidestationsHelper: gti height $counter is ${tidepoint.height}');
        counter++;
      });
    } catch (error) {
      print('TidestationsHelper: gti:Admiralty API get tidal events has failed');
    }
    return _localTidePoints;
  }
}
