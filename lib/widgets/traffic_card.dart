import 'package:flutter/material.dart';
import 'package:holidayapp2/models/place.dart';
import 'package:holidayapp2/pages/traffic_detail_map_page.dart';
import 'package:intl/intl.dart';
import '../models/trafficevent.dart';

class TrafficCard extends StatelessWidget {
  final PlaceLocation currentLocation;
  final TrafficEvent trafficevent;

  TrafficCard({this.currentLocation, this.trafficevent});
  @override
  Widget build(BuildContext context) {
    print('The eventtype is ${trafficevent.trafficeventtype}');
    final BuildContext scaffoldContext = context;

    return Card(
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(4),
        child: ListTile(
          leading: CircleAvatar(
            child: Padding(
              padding: EdgeInsets.all(2),
              child: FittedBox(
                child: Text(trafficevent.trafficeventtype.substring(0, 3)),
              ),
            ),
          ),
          title: Text(
              DateFormat('E dd/MM/yyyy H:mm').format(trafficevent.starttime),
              style: TextStyle(fontSize: 12)),
          subtitle: Text(
            trafficevent.trafficeventtype.toLowerCase(),
            style: TextStyle(fontSize: 10),
          ),
          trailing:
              _buildButtonBar(scaffoldContext, currentLocation, trafficevent),
        ),
      ),
    );
  }
}

Widget _buildButtonBar(
    BuildContext ctx, PlaceLocation currloc, TrafficEvent trafficevent) {
  List<PlaceLocation> mapitems = [
    PlaceLocation(
        latitude: currloc.latitude,
        longitude: currloc.longitude,
        address: "Current Location"),
    PlaceLocation(
        latitude: trafficevent.origin.latitude,
        longitude: trafficevent.origin.longitude,
        address: trafficevent.comments)
  ];

  return Container(
    width: 100,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
            icon: Icon(
              Icons.details,
            ),
            onPressed: () {
              _showTrafficCommentsSnackBar(ctx, trafficevent.comments);
            }),
        IconButton(
            icon: Icon(
              Icons.map,
            ),
            onPressed: () {
              print("Detected map detail pressed");
              //Navigator.of(ctx).pushNamed(TrafficDetailMapPage.routeName,
              //    arguments: mapitems);
              Navigator.push(
                ctx,
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      TrafficDetailMapPage(mapitems),
                ),
              );
            }),
      ],
    ),
  );
}

void _showTrafficCommentsSnackBar(BuildContext ctx, String comment) {
  final snackBar =
      new SnackBar(duration: Duration(seconds: 5), content: Text(comment));
  Scaffold.of(ctx).hideCurrentSnackBar();
  Scaffold.of(ctx).showSnackBar(snackBar);
}
