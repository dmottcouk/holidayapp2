import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/accuweatherweather.dart';
import '../models/accuweatherweatherwithdart.dart';
import '../models/place.dart';
import '../shared/global_config.dart';

class AccuweatherHelper {
  static Future<Accuweatherweather> getTodaysAccuweather(
      PlaceLocation loc) async {
    // first of all we need to get the location key by calling to http://dataservice.accuweather.com/locations/v1/cities/geoposition/search

    final Uri locationkeyqueryuri = Uri.http('dataservice.accuweather.com',
        '/locations/v1/cities/geoposition/search', {
      'apikey': ACCU_API_KEY,
      'q': '${loc.latitude},${loc.longitude}',
    });
    print('final locationkeyquery uri = ${locationkeyqueryuri.toString()}');
    final http.Response locationkeyresponse =
        await http.get(locationkeyqueryuri);
    final locationkeydecodedResponse = json.decode(locationkeyresponse.body);
    print('locationkeydecodedResponse = ${locationkeydecodedResponse}');
    final locationkey = locationkeydecodedResponse['Key'];
    print('key = $locationkey');

    String accuweatherUri =
        'http://dataservice.accuweather.com/forecasts/v1/daily/1day/$locationkey?apikey=$ACCU_API_KEY&metric=true';

    final http.Response accueweatherresp = await http.get(accuweatherUri);

    final accuweatherdecodedResponse = json.decode(accueweatherresp.body);
    final accuweatherdart =
        AccuweatherweatherWithDart.fromJson(accuweatherdecodedResponse);

    print(
        'accuweatherwith dart headline date = ${accuweatherdart.headline.effectiveDate}');
    print(
        'accuweatherwith dart headline severity = ${accuweatherdart.headline.severity.toString()}');

    print(
        'accuweatherwith dart headline text = ${accuweatherdart.headline.text}');
    print(
        'accuweatherwith dart headline category = ${accuweatherdart.headline.category}');
    print(
        'accuweatherwith dart headline enddate = ${accuweatherdart.headline.endDate}');

    print(
        'accuweatherwith dart fcast date = ${accuweatherdart.dailyForecasts[0].date}');
    print(
        'accuweatherwith dart fcast min temp = ${accuweatherdart.dailyForecasts[0].temperature.minimum.value.toString()}');
    print(
        'accuweatherwith dart fcast max temp = ${accuweatherdart.dailyForecasts[0].temperature.maximum.value.toString()}');

    print(
        'accuweatherwith dart day icon = ${accuweatherdart.dailyForecasts[0].day.icon.toString()}');
    print(
        'accuweatherwith dart day phrase = ${accuweatherdart.dailyForecasts[0].day.iconPhrase}');
    print(
        'accuweatherwith dart day has precip = ${accuweatherdart.dailyForecasts[0].day.hasPrecipitation.toString()}');
    print(
        'accuweatherwith dart day precip type= ${accuweatherdart.dailyForecasts[0].day.precipitationType}');
    print(
        'accuweatherwith dart day precip intensity= ${accuweatherdart.dailyForecasts[0].day.precipitationIntensity}');

    print(
        'accuweatherwith dart night icon = ${accuweatherdart.dailyForecasts[0].night.icon.toString()}');
    print(
        'accuweatherwith dart night phrase = ${accuweatherdart.dailyForecasts[0].night.iconPhrase}');
    print(
        'accuweatherwith dart night has precip = ${accuweatherdart.dailyForecasts[0].night.hasPrecipitation.toString()}');
    print(
        'accuweatherwith dart night precip type= ${accuweatherdart.dailyForecasts[0].night.precipitationType}');
    print(
        'accuweatherwith dart night precip intensity= ${accuweatherdart.dailyForecasts[0].night.precipitationIntensity}');

    //final http.Response trafficresponse = await http.get(trafficuri);
    //final http.Response trafficresponse = await http.get(myUri);
    //print('Got the trafficresponse');
    //final trafficdecodedResponse = json.decode(trafficresponse.body);
    //print('decode = $trafficdecodedResponse');
    //TrafficEvents tevents = TrafficEvents.fromJson(trafficdecodedResponse);
    //print('version = ${tevents.vERSION.toString()}');


return Accuweatherweather(
        headlinedate: DateTime.parse(accuweatherdart.headline.effectiveDate),
        headlineseverity: accuweatherdart.headline.severity,
        headlinetext: accuweatherdart.headline.text,
        headlinecategory: accuweatherdart.headline.category,
        headlineenddate: DateTime.parse(accuweatherdart.headline.endDate),
        forecastdate: DateTime.parse(accuweatherdart.dailyForecasts[0].date),
        forecastmintemp: accuweatherdart.dailyForecasts[0].temperature.minimum.value,
        forecastmaxtemp: accuweatherdart.dailyForecasts[0].temperature.maximum.value,
        dayiconnumber: accuweatherdart.dailyForecasts[0].day.icon,
        dayiconphrase: accuweatherdart.dailyForecasts[0].day.iconPhrase,
        dayhasprecipitation: accuweatherdart.dailyForecasts[0].day.hasPrecipitation,
        dayprecipitationtype: accuweatherdart.dailyForecasts[0].day.precipitationType,
        dayprecipitationintensity: accuweatherdart.dailyForecasts[0].day.precipitationIntensity,
        nighticonnumber: accuweatherdart.dailyForecasts[0].night.icon,
        nighticonphrase: accuweatherdart.dailyForecasts[0].night.iconPhrase,
        nighthasprecipitation: accuweatherdart.dailyForecasts[0].night.hasPrecipitation,
        nightprecipitationtype: accuweatherdart.dailyForecasts[0].night.precipitationType,
        nightprecipitationintensity: accuweatherdart.dailyForecasts[0].night.precipitationIntensity);
  }


/*

    return Accuweatherweather(
        headlinedate: DateTime.now(),
        headlineseverity: 1,
        headlinetext:
            'Tropical Rainstorm Gabrielle will affect the area Thursday',
        headlinecategory: 'tropical',
        headlineenddate: DateTime.now(),
        forecastdate: DateTime.now(),
        forecastmintemp: 10.5,
        forecastmaxtemp: 17.3,
        dayiconnumber: 1,
        dayiconphrase: 'Partly sunny w/ showers',
        dayhasprecipitation: true,
        dayprecipitationtype: 'Rain',
        dayprecipitationintensity: 'Light',
        nighticonnumber: 7,
        nighticonphrase: 'Partly cloudy',
        nighthasprecipitation: true,
        nightprecipitationtype: 'Rain',
        nightprecipitationintensity: 'Light');
  }
  */
}
