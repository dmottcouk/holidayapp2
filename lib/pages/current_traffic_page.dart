import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/currenttrafficevents_provider.dart';
import '../models/place.dart';
import '../widgets/traffic_card.dart';

class CurrentTrafficPage extends StatefulWidget {
  static const routeName = '/traffic';
  PlaceLocation loc;
  Map<String, bool> trafsettings;
  CurrentTrafficPage(this.loc, this.trafsettings);

  @override
  _CurrentTrafficPageState createState() => _CurrentTrafficPageState();
}

class _CurrentTrafficPageState extends State<CurrentTrafficPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Traffic'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.view_array),
            onPressed: () {
              _displayEventCounts(context);
            },
          )
        ],
      ),
      body: FutureBuilder(
        future:
            //Provider.of<CurrentTrafficEventsProvider>(context, listen: false)
            //    .fetchAndSetTrafficEvents(widget.loc),

            Provider.of<CurrentTrafficEventsProvider>(context, listen: false)
                .fetchAndSetTrafficEventsWithFilter(
                    widget.loc, widget.trafsettings),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          else {
            if (snapshot.error != null) {
              return Center(
                child: Text('CurrentTrafficPage: An error occurred'),
              );
            } else {
              return Consumer<CurrentTrafficEventsProvider>(
                  child: Center(
                    child: _imageBuilder2(context),
                  ),
                  builder: (ctx, trafficevents, ch) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: ch,
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.lightGreen,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: trafficevents.trafficevents.length == 0
                                ? Center(
                                    child: Text('No events'),
                                  )
                                : ListView.builder(
                                    itemCount:
                                        trafficevents.trafficevents.length,
                                    itemBuilder: (ctx, i) => TrafficCard(currentLocation: widget.loc,
                                        trafficevent:trafficevents.trafficevents[i]),
                                  ),
                          ),
                        )
                      ],
                    );
                  });
            }
          }
        },
      ),
    );
  }

  Widget _imageBuilder2(BuildContext ctx) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
          color: Theme.of(ctx).primaryColorLight,
          borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Image.asset(
          'assets/images/highwaytraffic.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

void _displayEventCounts(BuildContext ctx) {
  //
  final eventStats =
      Provider.of<CurrentTrafficEventsProvider>(ctx, listen: false)
          .eventsByType;
  showModalBottomSheet(
    context: ctx,
    builder: (_) {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                width: 200,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Theme.of(ctx).primaryColorLight,
                    borderRadius: BorderRadius.circular(15)),
                child: Text(
                  'Traffic types',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            //SizedBox(height: 15),
            //Row(children: <Widget>[
            //  Text('Accident'),
            //  SizedBox(width: 12),
            //  Text('2'),
            //])
            Expanded(
              flex: 10,
              child: Container(
                child: ListView.builder(
                    itemCount: eventStats.length,
                    itemBuilder: (ctx, index) {
                      String key = eventStats.keys.elementAt(index);
                      return Container(
                          margin: EdgeInsets.all(10),
                          child: Row(children: <Widget>[
                            Text('${key} : '),
                            Text(eventStats[key].toString())
                          ]));
                    }),
              ),
            )
          ]);
    },
  );
}
