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
            markerId: MarkerId('*'),
            position: LatLng(currentLocation.latitude, currentLocation.longitude),
          )
        },
      ),
    );
  }
}
