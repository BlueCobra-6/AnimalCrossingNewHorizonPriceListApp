import 'package:flutter/material.dart';

import 'package:rate_my_app/rate_my_app.dart';

import 'routes/pageRoutes.dart';
import 'fragments/contactPage.dart';
import 'fragments/animalPriceListPage.dart';
import 'fragments/privacyPolicyPage.dart';
import 'fragments/feedbackPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Animal Crossing Price List';

  final RateMyApp _rateMyApp = RateMyApp(
      preferencesPrefix: 'rateMyApp_',
      minDays: 7,
      minLaunches: 50,
      remindDays: 30,
      remindLaunches: 100
  );



  @override
  Widget build(BuildContext context) {
    _rateMyApp.init().then((_){
      if(_rateMyApp.shouldOpenDialog) { //conditions check if user already rated the app
        _rateMyApp.showRateDialog(
          context,
          ignoreNativeDialog: false,
        );
      }
    });
    return new MaterialApp(
      title: _title,
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      home: AnimalPriceListPage(),
      routes:  {
        PageRoutes.price: (context) => AnimalPriceListPage(),
        PageRoutes.feedback: (context) => FeedbackPage(),
        PageRoutes.contact: (context) => ContactPage(),
        PageRoutes.privacy: (context) => PrivacyPolicyPage(),
      },
    );
  }
}
