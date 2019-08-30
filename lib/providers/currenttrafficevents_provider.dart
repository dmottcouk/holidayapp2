

import 'package:flutter/material.dart';

import '../models/trafficevent.dart';
import '../models/place.dart';
import '../helpers/currenttraffic_helper.dart';
//import '../models/trafficsettings.dart';

class CurrentTrafficEventsProvider extends ChangeNotifier {

List<TrafficEvent> _currentTrafficEvents;

List<TrafficEvent> get trafficevents
{
  return[..._currentTrafficEvents];

}

 Future<void> fetchAndSetTrafficEvents(PlaceLocation loc) async {
   print('CurrentTrafficSettingsProvider:fetchAndSetTrafficEvents entered');
    _currentTrafficEvents = await CurrentTrafficHelper.getCurrentTraffic(loc);
    //_dataObtained = true;
    notifyListeners();
  }

  Future<void> fetchAndSetTrafficEventsWithFilter(PlaceLocation loc, Map<String, bool> trafficsettings) async {
   print('CurrentTrafficSettingsProvider:fetchAndSetTrafficEventsWithFilter entered');
    _currentTrafficEvents = await CurrentTrafficHelper.getCurrentTrafficWithFilter(loc, trafficsettings);
    //_dataObtained = true;
    notifyListeners();
  }

}