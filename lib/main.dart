import 'package:flutter/material.dart';

import 'routes/pageRoutes.dart';
import 'fragments/contactPage.dart';
import 'fragments/animalPriceListPage.dart';
import 'fragments/appInfoPage.dart';

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
        PageRoutes.contact: (context) => ContactPage(),
        PageRoutes.info: (context) => AppInfoPage(),
      },
    );
  }
}