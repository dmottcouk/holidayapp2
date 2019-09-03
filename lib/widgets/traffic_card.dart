import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/trafficevent.dart';

class TrafficCard extends StatelessWidget {
  final TrafficEvent trafficevent;

  TrafficCard(this.trafficevent);
  @override
  Widget build(BuildContext context) {
    print('The eventtype is ${trafficevent.trafficeventtype}');
    final BuildContext scaffoldContext = context;
    ;
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
            DateFormat('E dd/MM/yyyy H:mm').format(trafficevent.entrytime),
          ),
          subtitle: Text('traffic...'),
          trailing: _buildButtonBar(scaffoldContext, trafficevent),
        ),
      ),
    );
  }
}

Widget _buildButtonBar(BuildContext ctx, TrafficEvent trafficevent) {
  return Container(
    width: 100,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            onPressed: () {}),
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
