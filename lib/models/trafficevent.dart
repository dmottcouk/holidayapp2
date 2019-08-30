import './place.dart';

class TrafficEvent{
  String id;
  DateTime datestamp;
  DateTime starttime;
  DateTime endtime;
  DateTime entrytime;
  String criticality;
  String trafficeventtype;
  String status;
  String comments;
  PlaceLocation origin;
  PlaceLocation to;  // note this was bodged in the trafficeventswithdart file to be TOO
  num distancefromcurrentlocationmeters;

  TrafficEvent({this.id, this.datestamp, this.starttime, this.endtime, this.entrytime, this.criticality, this.trafficeventtype, this.status, this.comments, this.origin, this.to, distancefromcurrentlocationmeters});
}
