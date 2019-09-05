import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';

class MapScreen extends StatefulWidget {
  static const routeName = '/map';

  @override
  _MapScreenState createState() => _MapScreenState();

  // use didChangeDependencies to get the passed arguments in pushNamed
}

class _MapScreenState extends State<MapScreen> {
  PlaceLocation currentLocation;

  @override
  void didChangeDependencies() {
    currentLocation =
        ModalRoute.of(context).settings.arguments as PlaceLocation;

    print(
        'MapScreen :didChangeDependencies : lat=${currentLocation.latitude} lat=${currentLocation.longitude} ');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your location',
        ),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            currentLocation.latitude,
            currentLocation.longitude,
          ),
          zoom: 16,
        ),
        // a set is a bit like a list but the values are guaranteed to be unique
        markers: {
          Marker(
              markerId: MarkerId('A'),
              position:
                  LatLng(currentLocation.latitude, currentLocation.longitude),
              onTap: () {
                _showTrafficCommentsDialog(
                    context, "Your current location");
              })
        },
      ),
    );
  }

  void _showTrafficCommentsSnackBar(BuildContext ctx, String comment) {
    // does not work
    final snackBar =
        new SnackBar(duration: Duration(seconds: 5), content: Text(comment));
    Scaffold.of(ctx).hideCurrentSnackBar();
    Scaffold.of(ctx).showSnackBar(snackBar);
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
