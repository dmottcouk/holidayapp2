import 'package:flutter/material.dart';
import 'package:location/location.dart' as geoloc;
import '../helpers/location_helper2.dart';

class LocationStaticMap extends StatefulWidget {
  Function setTheLocation;
  LocationStaticMap(this.setTheLocation);

  @override
  _LocationStaticMapState createState() => _LocationStaticMapState();
}

class _LocationStaticMapState extends State<LocationStaticMap> {
  // _staticMapUri is actually a String
  String _staticMapUri;

  @override
  void initState() {
    _staticMapUri = null;

    // get the current location in initstate?
    _getUserLocationAndMapUri();

    //print("In initState : Screen width = ${MediaQuery.of(context).size.width}");
    //print("In initState : Screen height = ${MediaQuery.of(context).size.height}");
    super.initState();
  }

  void _getUserLocationAndMapUri() async {
    print("widgets: _getUserLocationAndMap");

    try {
      final currentLocation = await LocationHelper2.getCurrentLocation();

      print(
          "_getUserLocationAndMap : currentLocation.latitude = ${currentLocation.latitude}");
      print(
          "_getUserLocationAndMap : currentLocation.longitudr = ${currentLocation.longitude}");

      print("Call _getStaticMap2");

      setState(() {
        _staticMapUri = LocationHelper2.generateLocationPreviewImage(
            latitude: currentLocation.latitude,
            longitude: currentLocation.longitude);
      });
      widget.setTheLocation(
          currentLocation.latitude, currentLocation.longitude);
    } catch (error) {
      print("Error getting user location");
    }
  }

  Widget _waitingForMapPlaceHolder() {
    return Center(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Waiting for a map ...:',
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            'Holiday App 2',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.display1,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _staticMapUri == null
          ? _waitingForMapPlaceHolder()
          : Image.network(
              _staticMapUri,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
    );
  }
}