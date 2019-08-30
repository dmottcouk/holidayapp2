import 'package:flutter/material.dart';

import '../models/currentweather.dart';
import '../models/place.dart';
import '../helpers/currentweather_helper.dart';


class CurrentWeatherProvider extends ChangeNotifier {
  bool _dataObtained = false;
  CurrentWeather _todaysWeather;

  bool get dataReady {
    return _dataObtained;
  }

  CurrentWeather get theWeather
  {
    final weather = _todaysWeather;
    return(weather);
  }

  Future<void> fetchAndSetWeather(PlaceLocation loc) async {
    _todaysWeather = await CurrentWeatherHelper.getCurrentWeather(loc);
    _dataObtained = true;
    notifyListeners();
  }
}