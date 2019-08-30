import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:latlong/latlong.dart';

import '../models/place.dart';
import '../models/trafficevent.dart';
import '../models/trafficeventswithdart.dart';
import '../shared/global_config.dart';

class CurrentTrafficHelper {
  static String _convertToISO8601(String trafficdate) {
    var datesplits = trafficdate.split('/');
    var month = datesplits[0];
    var date = datesplits[1];
    var year = datesplits[2].substring(0, 4);
    print('Decoded timestamp month = $month, date = $date, year = $year');
    var timesplits1 = trafficdate.split(' ');
    var timesplits2 = timesplits1[1].split(':');
    var hour = timesplits2[0];
    var min = timesplits2[1];
    var sec = timesplits2[2];
    print('Decoded timestamp hour = $hour, min = $min, sec = $sec');
    bool isGMTTime = trafficdate.contains('GMT');
    var myformatteddatstring =
        year + '-' + month + '-' + date + ' ' + hour + ':' + min + ':' + sec;
    if (!isGMTTime) myformatteddatstring += '+01:00';
    print('ISO string for datetime = $myformatteddatstring');
    return myformatteddatstring;
  }

  static Future<List<TrafficEvent>> getCurrentTraffic(PlaceLocation loc) async {
    // we are just going to create a bounding box based on the current location and see what happens

    print("CurrentTrafficHelper: getCurrentTraffic: Trying to get the traffic");
    print("CurrentTrafficHelper:Latitude = ${loc.latitude}");
    print("CurrentTrafficHelper:Longitude = ${loc.longitude}");

    //double lowerLeftCornerLatitude = loc.latitude - 0.06;
    //double lowerLeftCornerLongitude = loc.longitude - 0.09;
    //double upperRightCornerLatitude = loc.latitude + 0.06;
    //double upperRightCornerLongitude = loc.longitude + 0.09;

    double lowerLeftCornerLatitude = loc.latitude - 0.04;
    double lowerLeftCornerLongitude = loc.longitude - 0.04;
    double upperRightCornerLatitude = loc.latitude + 0.04;
    double upperRightCornerLongitude = loc.longitude + 0.04;

    final List<TrafficEvent> events = [];
    //  class TrafficEvent{
    // String id;
    // DateTime datestamp;
    // DateTime starttime;
    // DateTime endtime;
    // DateTime entrytime;
    // String criticality;
    // String trafficeventeventtype;
    // String status;
    // String comments;
    // PlaceLocation origin;
    // PlaceLocation to;  // note this was bodged in the trafficeventswithdart file to be TOO
    // double distancefromcurrentlocationmiles;
//}

    try {
      final Uri trafficuri =
          Uri.https('traffic.api.here.com', '/traffic/6.3/incidents.json', {
        'app_id': hereapp_id,
        'app_code': hereapp_code,
        'bbox': lowerLeftCornerLatitude.toString() +
            ',' +
            lowerLeftCornerLongitude.toString() +
            ':' +
            upperRightCornerLatitude.toString() +
            ',' +
            upperRightCornerLongitude.toString(),

        'criticality': 'critical,major'
      });
      print('final uri = ${trafficuri.toString()}');
      const app_id = hereapp_id;
      const app_code = hereapp_code;

      String myUri =
          'https://traffic.api.here.com/traffic/6.3/incidents.json?app_id=${app_id}&app_code=${app_code}&bbox=${lowerLeftCornerLatitude},${lowerLeftCornerLongitude};${upperRightCornerLatitude},${upperRightCornerLongitude}&criticality=critical,major';

      //final http.Response trafficresponse = await http.get(trafficuri);
      final http.Response trafficresponse = await http.get(myUri);
      print('Got the trafficresponse');
      final trafficdecodedResponse = json.decode(trafficresponse.body);
      print('decode = $trafficdecodedResponse');
      TrafficEvents tevents = TrafficEvents.fromJson(trafficdecodedResponse);
      print('version = ${tevents.vERSION.toString()}');

      print('number of events = ${tevents.tRAFFICITEMS.tRAFFICITEM.length}');

      // for each Trafficitem create a trafficevent object

      print('timestamp = ${tevents.tIMESTAMP}');

      String fmtdatestamp = _convertToISO8601(tevents.tIMESTAMP);

      DateTime datestamp = DateTime.parse(fmtdatestamp);
      print('the event timestamp will be .... ${datestamp.toIso8601String()}');

      tevents.tRAFFICITEMS.tRAFFICITEM.forEach((item) {
        var titemitemid = item.oRIGINALTRAFFICITEMID;
        print('the event id will be .... ${titemitemid.toString()}');
        var titemstarttime = item.sTARTTIME;
        print('the event starttime will be .... ${titemstarttime}');
        var titemendtime = item.eNDTIME;
        print('the event endtime will be .... ${titemendtime}');
        var titementrytime = item.eNTRYTIME;
        print('the event entrytime will be .... ${titementrytime}');
        var criticality = item.cRITICALITY.dESCRIPTION;
        print('the event criticality will be .... ${criticality}');
        var trafficeventeventtype = item.tRAFFICITEMTYPEDESC;
        print('the event type  will be .... ${trafficeventeventtype}');
        var status = item.tRAFFICITEMSTATUSSHORTDESC;
        print('the status short desc  will be .... ${status}');
        var comments = item.cOMMENTS;
        print('the comments  will be .... ${comments}');
        var geolocoriginlat = item.lOCATION.gEOLOC.oRIGIN.lATITUDE;
        print('the origin lat  will be .... ${geolocoriginlat.toString()}');
        var geolocoriginlong = item.lOCATION.gEOLOC.oRIGIN.lONGITUDE;
        print('the origin long  will be .... ${geolocoriginlong.toString()}');
        print('the location lat  will be .... ${loc.latitude.toString()}');
        print('the location long  will be .... ${loc.longitude.toString()}');
        print('length of Too is ${item.lOCATION.gEOLOC.tOO.length}');
        var geoloctolat = item.lOCATION.gEOLOC.tOO[0].lATITUDE;
        print('the to lat  will be .... ${geoloctolat.toString()}');
        var geoloctolong = item.lOCATION.gEOLOC.tOO[0].lONGITUDE;
        print('the to long  will be .... ${geoloctolong.toString()}');
        Distance distance = new Distance();
        // distance in m

        num dist = distance.as(
          LengthUnit.Meter,
          new LatLng(geolocoriginlat, geolocoriginlong),
          new LatLng(loc.latitude, loc.longitude),
        );
        print('the distance  will be .... ${dist.toString()} m');

        events.add(TrafficEvent(
            id: titemitemid.toString(),
            datestamp: datestamp,
            starttime: DateTime.parse(_convertToISO8601(titemstarttime)),
            endtime: DateTime.parse(_convertToISO8601(titemendtime)),
            entrytime: DateTime.parse(_convertToISO8601(titementrytime)),
            criticality: criticality,
            trafficeventtype: trafficeventeventtype,
            status: status,
            comments: comments,
            origin: PlaceLocation(
                latitude: geolocoriginlat,
                longitude: geolocoriginlong,
                address: 'event location'),
            to: PlaceLocation(
                latitude: geoloctolat,
                longitude: geoloctolong,
                address: 'event to'),
            distancefromcurrentlocationmeters: dist));
      });
    } catch (error) {
      print(
          'CurrentTrafficHelper: Exception in getting the traffic ${error.toString()}');
    } finally {
      return events;
    }
  }

  static Future<List<TrafficEvent>> getCurrentTrafficWithFilter(
      PlaceLocation loc, Map<String, bool> trafficsettings) async {
    print("CurrentTrafficHelper: getCurrentTraffic: Trying to get the traffic");
    print("CurrentTrafficHelper:Latitude = ${loc.latitude}");
    print("CurrentTrafficHelper:Longitude = ${loc.longitude}");

    //double lowerLeftCornerLatitude = loc.latitude - 0.06;
    //double lowerLeftCornerLongitude = loc.longitude - 0.09;
    //double upperRightCornerLatitude = loc.latitude + 0.06;
    //double upperRightCornerLongitude = loc.longitude + 0.09;

    double lowerLeftCornerLatitude = loc.latitude - 0.04;
    double lowerLeftCornerLongitude = loc.longitude - 0.04;
    double upperRightCornerLatitude = loc.latitude + 0.04;
    double upperRightCornerLongitude = loc.longitude + 0.04;

    final List<TrafficEvent> events = [];

    try {
      final Uri trafficuri =
          Uri.https('traffic.api.here.com', '/traffic/6.3/incidents.json', {
        'app_id': hereapp_id,
        'app_code': hereapp_code,
        'bbox': lowerLeftCornerLatitude.toString() +
            ',' +
            lowerLeftCornerLongitude.toString() +
            ':' +
            upperRightCornerLatitude.toString() +
            ',' +
            upperRightCornerLongitude.toString(),

        'criticality': 'critical,major'
      });
      print('final uri = ${trafficuri.toString()}');
      const app_id = hereapp_id;
      const app_code = hereapp_code;

      String myUri =
          'https://traffic.api.here.com/traffic/6.3/incidents.json?app_id=${app_id}&app_code=${app_code}&bbox=${lowerLeftCornerLatitude},${lowerLeftCornerLongitude};${upperRightCornerLatitude},${upperRightCornerLongitude}&criticality=critical,major';

      String tyappend = '&type=RoadClosure';
      if (trafficsettings['allenabled'] == false) {
        if (trafficsettings['accidentenabled'] == true) {
          tyappend += ',Accident';
        }
        if (trafficsettings['congestionenabled'] == true) {
          tyappend += ',Congestion';
        }
        if (trafficsettings['disabledvehicle'] == true) {
          tyappend += ',DisabledVehicle';
        }
        if (trafficsettings['roadhazard'] == true) {
          tyappend += ',RoadHazard';
        }
        if (trafficsettings['construction'] == true) {
          tyappend += ',Construction';
        }

        myUri += tyappend;
      }

      print('final uri with filters = ${myUri}');

      //_mastertrafficsettings = {
      //    'allenabled': true,
      //    'accidentenabled': false,
      //    'congestionenabled': false,
      //    'disabledvehicle': false,
      //    'roadhazard': false,
      //    'construction': false,
      //    'roadclosure': false
      //  };

      //final http.Response trafficresponse = await http.get(trafficuri);
      final http.Response trafficresponse = await http.get(myUri);
      print('Got the trafficresponse');
      final trafficdecodedResponse = json.decode(trafficresponse.body);
      print('decode = $trafficdecodedResponse');
      TrafficEvents tevents = TrafficEvents.fromJson(trafficdecodedResponse);
      print('version = ${tevents.vERSION.toString()}');

      //print('number of events = ${tevents.tRAFFICITEMS.tRAFFICITEM.length}');

      // for each Trafficitem create a trafficevent object

      print('timestamp = ${tevents.tIMESTAMP}');

      String fmtdatestamp = _convertToISO8601(tevents.tIMESTAMP);

//2019-08-28T05:35:47+01:00

      DateTime datestamp = DateTime.parse(fmtdatestamp);
      print('the event timestamp will be .... ${datestamp.toIso8601String()}');
      print('tRAFFICITEMS to string is ${tevents.tRAFFICITEMS.toString()}');
      if((!tevents.tRAFFICITEMS.toString().contains('TRAFFICITEM')) || (tevents.tRAFFICITEMS.tRAFFICITEM.length == 0)) 
      {
        print('Traffic with filter no results. Return empty list');
        return events;
      }
      tevents.tRAFFICITEMS.tRAFFICITEM.forEach((item) {
        var titemitemid = item.oRIGINALTRAFFICITEMID;
        print('the event id will be .... ${titemitemid.toString()}');
        var titemstarttime = item.sTARTTIME;
        print('the event starttime will be .... ${titemstarttime}');
        var titemendtime = item.eNDTIME;
        print('the event endtime will be .... ${titemendtime}');
        var titementrytime = item.eNTRYTIME;
        print('the event entrytime will be .... ${titementrytime}');
        var criticality = item.cRITICALITY.dESCRIPTION;
        print('the event criticality will be .... ${criticality}');
        var trafficeventeventtype = item.tRAFFICITEMTYPEDESC;
        print('the event type  will be .... ${trafficeventeventtype}');
        var status = item.tRAFFICITEMSTATUSSHORTDESC;
        print('the status short desc  will be .... ${status}');
        var comments = item.cOMMENTS;
        print('the comments  will be .... ${comments}');
        var geolocoriginlat = item.lOCATION.gEOLOC.oRIGIN.lATITUDE;
        print('the origin lat  will be .... ${geolocoriginlat.toString()}');
        var geolocoriginlong = item.lOCATION.gEOLOC.oRIGIN.lONGITUDE;
        print('the origin long  will be .... ${geolocoriginlong.toString()}');
        print('the location lat  will be .... ${loc.latitude.toString()}');
        print('the location long  will be .... ${loc.longitude.toString()}');
        print('length of Too is ${item.lOCATION.gEOLOC.tOO.length}');
        var geoloctolat = item.lOCATION.gEOLOC.tOO[0].lATITUDE;
        print('the to lat  will be .... ${geoloctolat.toString()}');
        var geoloctolong = item.lOCATION.gEOLOC.tOO[0].lONGITUDE;
        print('the to long  will be .... ${geoloctolong.toString()}');
        Distance distance = new Distance();
        // distance in m

        num dist = distance.as(
          LengthUnit.Meter,
          new LatLng(geolocoriginlat, geolocoriginlong),
          new LatLng(loc.latitude, loc.longitude),
        );
        print('the distance  will be .... ${dist.toString()} m');

        events.add(TrafficEvent(
            id: titemitemid.toString(),
            datestamp: datestamp,
            starttime: DateTime.parse(_convertToISO8601(titemstarttime)),
            endtime: DateTime.parse(_convertToISO8601(titemendtime)),
            entrytime: DateTime.parse(_convertToISO8601(titementrytime)),
            criticality: criticality,
            trafficeventtype: trafficeventeventtype,
            status: status,
            comments: comments,
            origin: PlaceLocation(
                latitude: geolocoriginlat,
                longitude: geolocoriginlong,
                address: 'event location'),
            to: PlaceLocation(
                latitude: geoloctolat,
                longitude: geoloctolong,
                address: 'event to'),
            distancefromcurrentlocationmeters: dist));
      });
    } catch (error) {
      print(
          'CurrentTrafficHelper: Exception in getting the traffic ${error.toString()}');
    } finally {
      return events;
    }
  }
}
