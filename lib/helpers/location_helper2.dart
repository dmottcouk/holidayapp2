import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:location/location.dart' as geoloc;
import '../models/place.dart';
import '../shared/global_config.dart';




class LocationHelper2 {
  static String generateLocationPreviewImage(
      {double latitude, double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude, $longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

  // this is reverse geocoding ie get an address back from a lat/lng
  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY';
    final response = await http.get(url);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }

  static Future<PlaceLocation> getCurrentLocation() async {
    try {
      print("LocationHelper: _getUserLocationAndMap");
      final location = geoloc.Location();

      final currentLocation = await location.getLocation();

      //final address = await _getAddress(
      //    currentLocation.latitude, currentLocation.longitude);
      print(
          "_getUserLocationAndMap : currentLocation.latitude = ${currentLocation.latitude}");
      print(
          "_getUserLocationAndMap : currentLocation.longitudr = ${currentLocation.longitude}");

      return (PlaceLocation(
          address: "Current Location",
          latitude: currentLocation.latitude,
          longitude: currentLocation.longitude));
    } catch (error) {
      print("Error getting user locations");
      throw error;
    }
  }

//reverse geocoding
//https://maps.googleapis.com/maps/api/geocode/json?latlng=40.714224,-73.961452&key=YOUR_API_KEY//
}
