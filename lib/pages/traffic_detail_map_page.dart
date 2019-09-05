import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';

class TrafficDetailMapPage extends StatefulWidget {
  static const routeName = '/trafficdetailmap';

  List<PlaceLocation> currentLocations = [];

  TrafficDetailMapPage(this.currentLocations);


  @override
  _TrafficDetailMapPageState createState() => _TrafficDetailMapPageState();
}

class _TrafficDetailMapPageState extends State<TrafficDetailMapPage> {
  @override
  Widget build(BuildContext context) {
    

    @override
    void didChangeDependencies() {
      print('TrafficDetailMapPage :didChangeDependencies :  ');
      widget.currentLocations =
          ModalRoute.of(context).settings.arguments as List<PlaceLocation>;

      super.didChangeDependencies();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Traffic Event',
        ),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.currentLocations[0].latitude,
            widget.currentLocations[0].longitude,
          ),
          zoom: 10,
        ),
        // a set is a bit like a list but the values are guaranteed to be unique
        markers: {
          Marker(
              markerId: MarkerId('A'),
              position: LatLng(
                  widget.currentLocations[0].latitude, widget.currentLocations[0].longitude),
              onTap: () {
                _showTrafficCommentsDialog(
                    context, widget.currentLocations[0].address);
              }),
          Marker(
              markerId: MarkerId('B'),
              position: LatLng(
                  widget.currentLocations[1].latitude, widget.currentLocations[1].longitude),
              onTap: () {
                _showTrafficCommentsDialog(
                    context, widget.currentLocations[1].address);
              }),
        },
      ),
    );
  }

  void _showTrafficCommentsDialog(BuildContext ctx, String comment) {
    showDialog(
      context: ctx,
      builder: (ctx) => AlertDialog(
        title: Text('Marker information'),
        content: Text(comment),
        actions: <Widget>[
          FlatButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ],
      ),
    );
  }
}
