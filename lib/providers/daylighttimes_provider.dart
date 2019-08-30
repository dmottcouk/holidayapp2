import 'package:flutter/material.dart';
import '../helpers/daylight_helper.dart';
import '../models/daylighttimes.dart';
import '../models/place.dart';

class DayLightTimesProvider extends ChangeNotifier {
  bool _dataObtained = false;
  DayLightTimes _todaysDayLightTimes;

  bool get dataReady {
    return _dataObtained ? true : false;
  }

  DayLightTimes get todaysDayLightTimes {
    final daylightTimes = _todaysDayLightTimes;
    return daylightTimes;
  }

  Future<void> fetchAndSetDaylightTimes(PlaceLocation loc) async {
    _todaysDayLightTimes = await DayLightHelper.getSunriseSunsetTimes(loc);
    _dataObtained = true;
    notifyListeners();
  }
}