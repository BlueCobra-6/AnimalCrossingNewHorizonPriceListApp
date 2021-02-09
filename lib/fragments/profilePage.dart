import 'package:flutter/material.dart';

import 'package:AnimalCrossingApp/navigationDrawer/navigationDrawer.dart';

class ProfilePage extends StatelessWidget {
  static const String routeName = '/profilePage';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("My Profile"),
        ),
        drawer: NavigationDrawer(),
        body: Center(child: Text("This is profile page")));
  }
}