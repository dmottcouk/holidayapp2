import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/currenttrafficsettings_provider.dart';

class TrafficFiltersScreen extends StatefulWidget {
  static const routeName = '/settings';

  @override
  _TrafficFiltersScreenState createState() => _TrafficFiltersScreenState();
}

class _TrafficFiltersScreenState extends State<TrafficFiltersScreen> {
// can maybe chanfge to a stateless widget

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Traffic Settings'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Traffic Settings',
              style: Theme.of(context).textTheme.title,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Consumer<CurrentTrafficSettingsProvider>(
              builder: (ctx, trafficSettings, _) {
                return ListView.builder(
                  itemCount: trafficSettings.settingCount,
                  itemBuilder: (ctx, i) => _trafficSwitchListTileBuilder(
                      trafficSettings.thetrafficsettings.keys.toList()[i],
                      trafficSettings.thetrafficsettings.values.toList()[i]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _trafficSwitchListTileBuilder(String traffickey, bool currentvalue) {
    print('traffic setting: $traffickey value $currentvalue');
    return (SwitchListTile(
      title: (Text(traffickey)),
      value: currentvalue,
      subtitle: Text('subtitle'),
      onChanged: (bool value) {
        Provider.of<CurrentTrafficSettingsProvider>(context, listen: false)
            .updateTheMasterTrafficSetting(traffickey, value);
      },
    ));
  }
}

/*
Consumer<GreatPlaces>(
                child: Center(
                  child: const Text('Got no places yet. Go add some'),
                ),
                builder: (ctx, greatPlaces, ch) => greatPlaces.items.length <= 0
                    ? ch
                    : ListView.builder(
                        itemCount: greatPlaces.items.length,
                        itemBuilder: (ctx, i) => ListTile(
                            leading: CircleAvatar(
                              //previously we used NetworkImage and AssetImage
                              backgroundImage: FileImage(
                                greatPlaces.items[i].image,
                              ),
                            ),
                            title: Text(greatPlaces.items[i].title),
                            subtitle: Text(greatPlaces.items[i].location.address),
                            onTap: () {
                              Navigator.of(context).pushNamed(PlaceDetailScreen.routeName, arguments: greatPlaces.items[i].id);
                            }),
                      ),
              ),*/
