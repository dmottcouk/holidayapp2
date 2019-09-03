import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/currenttides_provider.dart';
import '../models/place.dart';
import '../widgets/tide_card.dart';

class CurrentTidesPage extends StatelessWidget {

  static const routeName = '/tides';
  
  final PlaceLocation loc;
  CurrentTidesPage(this.loc);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Today\'s Tides,'),
      ),
      body: FutureBuilder(
        future: Provider.of<CurrentTidesProvider>(context, listen: false)
            .fetchAndSetTidePoints(loc),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          else {
            if (snapshot.error != null) {
              return Center(
                child: Text('CurrentTidesPage: An error occurred'),
              );
            } else {
              return Consumer<CurrentTidesProvider>(
                  child: Center(
                    child: _imageBuilder2(context),
                  ),
                  builder: (ctx, tides, ch) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          //child: ch,
                          child: _imageBuilder(
                              context, tides.theTidePoints[0].loc.address),
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
                            child: ListView.builder(
                                itemCount: tides.theTidePoints.length,
                                itemBuilder: (ctx, i) => TideCard(
                                    eventtype: tides.theTidePoints[i].eventtype,
                                    datestamp: DateTime.parse(tides
                                        .theTidePoints[i].datestamp
                                        .replaceAll('-', '')
                                        .replaceAll(':', '')),
                                    height: tides.theTidePoints[i].height)),
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

  Widget _imageBuilder(BuildContext ctx, String stationname) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
          color: Theme.of(ctx).primaryColorLight,
          borderRadius: BorderRadius.circular(15)),
      child: Stack(children: <Widget>[
        Image.asset(
          'assets/images/boatonoceanalpha1.png',
          fit: BoxFit.cover,
        ),
        Center(
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white70, borderRadius: BorderRadius.circular(12)),
            child: Text(
              stationname,
              style: TextStyle(color: Theme.of(ctx).accentColor, fontSize: 18),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _imageBuilder2(BuildContext ctx) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
          color: Theme.of(ctx).primaryColorLight,
          borderRadius: BorderRadius.circular(10)),
      child: Image.asset(
        'assets/images/boatonoceanalpha1.png',
        fit: BoxFit.cover,
      ),
    );
  }
}
