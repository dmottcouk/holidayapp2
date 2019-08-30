
import 'package:flutter/material.dart';
import '../helpers/tidestations_helper.dart';
import '../models/tidepoint3.dart';
import '../models/place.dart';


class CurrentTidesProvider extends ChangeNotifier {
  bool _dataObtained = false;
  List<TidePoint3> _todaysTides;

  bool get dataReady {
    return _dataObtained;
  }

List<TidePoint3> get theTidePoints
  {
    final tidepoints = _todaysTides;
    return(tidepoints);
  }

Future<void> fetchAndSetTidePoints(PlaceLocation loc) async {
    _todaysTides = await TidestationsHelper.getTideInformation(loc);
    _dataObtained = true;
    notifyListeners();
  }


}





