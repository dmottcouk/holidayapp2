import 'package:flutter/material.dart';

import '../models/place.dart';

class TidePoint3{
  String id;
  PlaceLocation loc;
  String eventtype;
  String datestamp;
  double height;
  

  TidePoint3({@required this.id, @required this.loc, @required this.eventtype, @required this.datestamp, @required this.height});

}