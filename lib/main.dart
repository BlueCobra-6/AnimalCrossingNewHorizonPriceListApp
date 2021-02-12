import 'package:flutter/material.dart';

import 'routes/pageRoutes.dart';
import 'fragments/contactPage.dart';
import 'fragments/animalPriceListPage.dart';
import 'fragments/privacyPolicyPage.dart';
import 'fragments/feedbackPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Animal Crossing Price List';

  @override
  Widget build(BuildContext context) {
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