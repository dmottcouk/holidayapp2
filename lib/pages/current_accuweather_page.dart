import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/currentaccuweather_provider.dart';
import '../models/accuweatherweather.dart';
import '../models/place.dart';
import '../widgets/accuweather_day.dart';
import '../widgets/accuweather_night.dart';

class CurrentAccuweatherPage extends StatefulWidget {
  static const routeName = '/accuweather';

  final PlaceLocation loc;
  CurrentAccuweatherPage(this.loc);

  @override
  _CurrentAccuweatherPageState createState() => _CurrentAccuweatherPageState();
}

class _CurrentAccuweatherPageState extends State<CurrentAccuweatherPage> {
  PageController _pageController;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void navigationTapped(int page) {
    // Animating to the page.
    // You can use whatever duration and curve you like
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Today\'s Accuweather weather'),
      ),
      body: PageView(
        children: [
          AccuweatherDay(loc: widget.loc),
          AccuweatherNight(loc: widget.loc),
        ],
        onPageChanged: onPageChanged,
        controller: _pageController,
      ),
      bottomNavigationBar: Theme(data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
          canvasColor: const Color(0xFF587c52),
        ), //
              child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.wb_sunny,
                  color: const Color(0xFFFFFFFF),
                ),
                title: Text(
                  "Day",
                  style: TextStyle(
                    color: const Color(0xFFFFFFFF),
                  ),
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.wb_cloudy,
                  color: const Color(0xff000000),
                ),
                title: Text(
                  "Night",
                  style: TextStyle(
                    color: const Color(0xff000000),
                  ),
                )),
          ],
          onTap: navigationTapped,
          currentIndex: _page,
        ),
      ),
    );
  }
}

/*
Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
          canvasColor: const Color(0xFF167F67),
        ), // sets the inactive color of the `BottomNavigationBar`
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.wb_sunny,
                  color: const Color(0xFFFFFFFF),
                ),
                title: Text(
                  "Day",
                  style: TextStyle(
                    color: const Color(0xFFFFFFFF),
                  ),
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.wb_cloudy,
                  color: const Color(0xFFFFFFFF),
                ),
                title: Text(
                  "Night",
                  style: TextStyle(
                    color: const Color(0xFFFFFFFF),
                  ),
                )),
          ],
          onTap: navigationTapped,
          currentIndex: _page,
        ),
      ),
      */
