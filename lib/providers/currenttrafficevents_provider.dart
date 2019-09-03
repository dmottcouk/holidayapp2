import 'package:flutter/material.dart';

import '../models/trafficevent.dart';
import '../models/place.dart';
import '../helpers/currenttraffic_helper.dart';
//import '../models/trafficsettings.dart';

class CurrentTrafficEventsProvider extends ChangeNotifier {
  List<TrafficEvent> _currentTrafficEvents;
  Map<String, int> _numByCategory;

  List<TrafficEvent> get trafficevents {
    return [..._currentTrafficEvents];
  }

  Map<String, int> get eventsByType {
    var accidentCount = 0;
    var congestionCount = 0;
    var disabledvehicleCount = 0;
    var roadhazardCount = 0;
    var constructionCount = 0;
    var plannedeventCount = 0;
    var masstransitCount = 0;
    var othernewsCount = 0;
    var weatherCount = 0;
    var miscCount = 0;
    var roadclosureCount = 0;
    var lanerestrictionCount = 0;
    print('For each event look at event type');

    _currentTrafficEvents.forEach((event) {
      switch (event.trafficeventtype.toLowerCase()) {
        case 'accident':
          accidentCount += 1;
          break;
        case 'congestion':
          congestionCount += 1;
          break;
        case 'disabledvehicle':
          disabledvehicleCount += 1;
          break;
        case 'roadhazard':
          roadhazardCount += 1;
          break;
        case 'construction':
          constructionCount += 1;
          break;
        case 'plannedevent':
          plannedeventCount += 1;
          break;
        case 'masstransit':
          masstransitCount += 1;
          break;
        case 'othernews':
          othernewsCount += 1;
          break;
        case 'weather':
          weatherCount += 1;
          break;
        case 'misc':
          miscCount += 1;
          break;
        case 'roadclosure':
          roadclosureCount += 1;
          break;
        case 'lane_restriction':
          lanerestrictionCount += 1;
          break;
      }
    });

    print('Return the map');
    return ({
      'accident': accidentCount,
      'congestion': congestionCount,
      'disabledvehicle': disabledvehicleCount,
      'roadhazard': roadhazardCount,
      'construction': constructionCount,
      'plannedevent': plannedeventCount,
      'masstransit': masstransitCount,
      'othernews': othernewsCount,
      'weather': weatherCount,
      'misc': miscCount,
      'roadclosure': roadclosureCount,
      'lanerestriction': lanerestrictionCount
    });
  }

  Future<void> fetchAndSetTrafficEvents(PlaceLocation loc) async {
    print('CurrentTrafficSettingsProvider:fetchAndSetTrafficEvents entered');
    _currentTrafficEvents = await CurrentTrafficHelper.getCurrentTraffic(loc);
    //_dataObtained = true;
    notifyListeners();
  }

  Future<void> fetchAndSetTrafficEventsWithFilter(
      PlaceLocation loc, Map<String, bool> trafficsettings) async {
    print(
        'CurrentTrafficSettingsProvider:fetchAndSetTrafficEventsWithFilter entered');
    _currentTrafficEvents =
        await CurrentTrafficHelper.getCurrentTrafficWithFilter(
            loc, trafficsettings);
    //_dataObtained = true;
    notifyListeners();
  }
}
