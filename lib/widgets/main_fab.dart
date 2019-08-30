import 'package:flutter/material.dart';

import 'dart:math' as math;

import '../pages/map_screen.dart';
import '../models/place.dart';

class MainFab extends StatefulWidget {
  PlaceLocation _currentLocation;
  MainFab(this._currentLocation);

  @override
  _MainFabState createState() => _MainFabState();
}

class _MainFabState extends State<MainFab> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync:
          this, // informs flutter that the naimation is applicable to this screen
      duration: Duration(milliseconds: 400),
    ); // vsync is unlocked by the TickerProviderStateMixin
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);

    return Column(
      mainAxisSize: MainAxisSize
          .min, // note that floatingActionButton in Scaffold is at bottom so this means min at bottom
      children: [
        Container(
          height: 70.0,
          width: 56.0,
          alignment: FractionalOffset
              .topCenter, // do positioning with the child size taken into account
          child: ScaleTransition(
            scale: CurvedAnimation(
                parent: _controller,
                curve: Interval(0.3, 1.0, curve: Curves.easeOut)),
            child: FloatingActionButton(
              child: Icon(Icons.refresh, color: Theme.of(context).primaryColor),
              backgroundColor: Theme.of(context).cardColor,
              heroTag: 'refresh',
              mini: true,
              onPressed: ()  {
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
          ),
        ),
        Container(
          height: 70.0,
          width: 56.0,
          alignment: FractionalOffset.topCenter,
          child: ScaleTransition(
            scale: CurvedAnimation(
                parent: _controller,
                curve: Interval(0.0, 0.6,
                    curve: Curves.easeOut)), // we done animating by 0.6 x 400
            child: FloatingActionButton(
              child: Icon(Icons.map, color: Colors.red),
              backgroundColor: Theme.of(context).cardColor,
              heroTag: 'map',
              mini: true,
              onPressed: () {
                widget._currentLocation != null
                    ? Navigator.of(context).pushNamed(MapScreen.routeName , arguments: widget._currentLocation)
                    : scaffold.showSnackBar(
                        SnackBar(
                          content: Text(
                            'Current Location Unknown',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                ;
              },
            ),
          ),
        ),
        FloatingActionButton(
          heroTag: 'options',
          onPressed: () {
            if (_controller.isDismissed) {
              _controller.forward(); // play the animation in forward direction
            } else {
              _controller.reverse();
            }
          },
          child: AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget child) {
              return Transform(
                alignment: FractionalOffset.center,
                transform: Matrix4.rotationZ(_controller.value * 0.5 * math.pi),
                child: Icon(
                    _controller.isDismissed ? Icons.more_vert : Icons.close),
              );
            },
          ),
        )
      ],
    );
  }
}
