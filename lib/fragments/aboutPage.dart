import 'package:flutter/material.dart';

import 'package:AnimalCrossingApp/navigationDrawer/navigationDrawer.dart';

class AboutPage extends StatelessWidget {
  static const String routeName = '/contactPage';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("About the app"),
          centerTitle: true,
          toolbarHeight: 40,
        ),
        drawer: NavigationDrawer(),
        body: Center(child: Text("This is contacts page")));
  }
}