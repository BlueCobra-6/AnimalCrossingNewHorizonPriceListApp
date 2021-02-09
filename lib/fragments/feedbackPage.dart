import 'package:flutter/material.dart';

import 'package:AnimalCrossingApp/navigationDrawer/navigationDrawer.dart';

class FeedbackPage extends StatelessWidget {
  static const String routeName = '/feedbackPage';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Provide Feedback"),
        ),
        drawer: NavigationDrawer(),
        body: Center(child: Text("This is feedback page")));
  }
}