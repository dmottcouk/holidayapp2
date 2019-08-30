import 'package:flutter/material.dart';
//import '../models/trafficsettings.dart';

class CurrentTrafficSettingsProvider extends ChangeNotifier {
  CurrentTrafficSettingsProvider() {
    print('CurrentTrafficSettingsProvider: constructor');
    _mastertrafficsettings = {
      'allenabled': true,
      'accidentenabled': false,
      'congestionenabled': false,
      'disabledvehicle': false,
      'roadhazard': false,
      'construction': false,
      'roadclosure': false
    };
  }

  bool _dataObtained =
      false; // eventually we will get this from stored_preferences
  Map<String, bool> _mastertrafficsettings;

  bool get dataReady {
    return _dataObtained;
  }

  int get settingCount {
    return _mastertrafficsettings.length;
  }

  Map<String, bool> get thetrafficsettings {
    print(
        'CurrentTrafficSettingsProvider: get trafficsettings length = ${_mastertrafficsettings.length}');
    //final ts = Map.from(_mastertrafficsettings);
    final ts = _mastertrafficsettings;
    return (ts);
  }

// this will be used stored_preferences eventually
  void fetchAndSetTrafficSettings() {
    if (_dataObtained == false) {
      _mastertrafficsettings = {
        'allenabled': true,
        'accidentenabled': false,
        'congestionenabled': false,
        'disabledvehicle': false,
        'roadhazard': false,
        'construction': false,
        'roadclosure': false
      };
    }
    // for now just create a blank
    _dataObtained = true;
    notifyListeners();
  }

  void updateTheMasterTrafficSetting(String key, bool newvalue) {
    print(
        'CurrentTrafficSettingsProvider: updateTheMasterTrafficSetting updateTheMasterTrafficSetting $key : $newvalue');
    if (_mastertrafficsettings.containsKey(key)) {
      if ((key.contains('allenabled') ||
          (_mastertrafficsettings['allenabled'] != true)))
        _mastertrafficsettings[key] = newvalue;
    } else {
      throw new Exception("Key does not exist");
    }
    if (_mastertrafficsettings['allenabled'] == true) {
      _mastertrafficsettings = {
        'allenabled': true,
        'accidentenabled': false,
        'congestionenabled': false,
        'disabledvehicle': false,
        'roadhazard': false,
        'construction': false,
        'roadclosure': false
      };
    }
    notifyListeners();
  }
}

// final bool allenabled;
// final bool accidentenabled;
// final bool congestionenabled;
// final bool disabledvehicle;
// final bool roadhazard;
// final bool construction;
//final bool masstransit;
//  final bool roadclosure;
