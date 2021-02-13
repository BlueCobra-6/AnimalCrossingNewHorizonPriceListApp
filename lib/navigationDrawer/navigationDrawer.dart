import 'package:flutter/material.dart';

import 'package:AnimalCrossingApp/routes/pageRoutes.dart';
import 'package:AnimalCrossingApp/widgets/appVersionWidget.dart';
import 'package:AnimalCrossingApp/widgets/createDrawerHeader.dart';
import 'package:AnimalCrossingApp/widgets/createDrawerBodyItem.dart';

class NavigationDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          createDrawerHeader(),
          createDrawerBodyItem(
            icon: Icons.pest_control,
            text: 'Price List',
            onTap: () =>
                Navigator.pushReplacementNamed(context, PageRoutes.price),
          ),
          Divider(),
          createDrawerBodyItem(
            icon: Icons.info,
            text: 'App info',
            onTap: () =>
                Navigator.pushReplacementNamed(context, PageRoutes.privacy),
          ),
          createDrawerBodyItem(
            icon: Icons.feedback,
            text: 'Feedback',
            onTap: () =>
                Navigator.pushReplacementNamed(context, PageRoutes.feedback),
          ),
          createDrawerBodyItem(
            icon: Icons.contact_phone,
            text: 'Contact Info',
            onTap: () =>
                Navigator.pushReplacementNamed(context, PageRoutes.contact),
          ),
          ListTile(
            title: appVersionWidget(),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
