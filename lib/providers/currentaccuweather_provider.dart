



import 'package:flutter/material.dart';

import '../helpers/accuweatherhelper.dart';
import '../models/accuweatherweather.dart';
import '../models/place.dart';

class CurrentAccuweatherProvider extends ChangeNotifier {

bool _dataObtained = false;
  Accuweatherweather _todaysWeather;

  bool get dataReady {
    return _dataObtained;
  }

  Accuweatherweather get theWeather
  {
    final weather = _todaysWeather;
    return(weather);
  }

  Future<void> fetchAndSetAccuWeather(PlaceLocation loc) async {
    _todaysWeather = await AccuweatherHelper.getTodaysAccuweather(loc);
    _dataObtained = true;
    notifyListeners();
  }
}