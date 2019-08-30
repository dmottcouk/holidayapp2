import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TideCard extends StatelessWidget {
  final String eventtype;
  final DateTime datestamp;
  final double height;

  TideCard({this.eventtype, this.datestamp, this.height});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(4),
        child: ListTile(
          leading: CircleAvatar(
            child: Padding(
              padding: EdgeInsets.all(2),
              child: FittedBox(
                child: this.eventtype.startsWith('HighWater')
                    ? Text('High')
                    : Text('Low'),
              ),
            ),
          ),
          title: Text(
            DateFormat('E dd/MM/yyyy H:mm').format(datestamp),
          ),
          subtitle: Text('Height'),
          trailing: Text('${height.toStringAsFixed(2)}'),
        ),
      ),
    );
  }
}
