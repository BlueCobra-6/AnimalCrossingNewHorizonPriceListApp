import 'package:flutter/material.dart';

import 'package:AnimalCrossingApp/navigationDrawer/navigationDrawer.dart';

class PrivacyPolicyPage extends StatelessWidget {
  static const String routeName = '/privacyPolicyPage';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Privacy Policy"),
          centerTitle: true,
          toolbarHeight: 40,
        ),
        drawer: NavigationDrawer(),
        body: Center(child: Text("This is notification page")));
  }
}