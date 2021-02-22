import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:AnimalCrossingApp/styles/focusedInputBorder.dart';
import 'package:AnimalCrossingApp/styles/unfocusedInputBorder.dart';
import 'package:AnimalCrossingApp/navigationDrawer/navigationDrawer.dart';

class FeedbackPage extends StatefulWidget {
  static const String routeName = '/feedbackPage';

  @override
  _FeedbackState createState() => _FeedbackState();
}

class _FeedbackState extends State<FeedbackPage> {

  launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURLMail({String subject = "", String body = ""}) async {
    Uri _emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'larson.l.tyler@gmail.com',
        queryParameters: {
          'subject': subject,
          'body': body
        }
    );

    var url = _emailLaunchUri.toString().replaceAll('+', '%20');
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();
  String name;
  String subject;
  String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Feedback"),
        centerTitle: true,
        toolbarHeight: 40,
      ),
      drawer: NavigationDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 14.0, horizontal: 13),
              child: Text(
                "Leave us a message, and we'll get in contact with you as soon as possible. ",
                style: TextStyle(
                  fontSize: 17.5,
                  height: 1.3,
                  fontFamily: 'RobotoSlab',
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                onChanged: (val) {
                  if (val != null || val.length > 0) name = val;
                },
                controller: t1,
                decoration: InputDecoration(
                  fillColor: Color(0xffe6e6e6),
                  filled: true,
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  hintText: 'Your name',
//                  hintStyle: TextStyle(
//                      color: Colors.blueGrey, fontFamily: 'RobotoSlab'),
                  border: unfocusedInputBorder(),
                  enabledBorder: unfocusedInputBorder(),
                  focusedBorder: focusedInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.0001,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                onChanged: (val) {
                  if (val != null || val.length > 0) subject = val;
                },
                controller: t2,
                decoration: InputDecoration(
                  fillColor: Color(0xffe6e6e6),
                  filled: true,
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  hintText: 'Subject',
//                  hintStyle: TextStyle(
//                      color: Colors.blueGrey, fontFamily: 'RobotoSlab'),
                  border: unfocusedInputBorder(),
                  enabledBorder: unfocusedInputBorder(),
                  focusedBorder: focusedInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.0001,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                onChanged: (val) {
                  if (val != null || val.length > 0) message = val;
                },
                textAlign: TextAlign.start,
                controller: t3,
                decoration: InputDecoration(
                  fillColor: Color(0xffe6e6e6),
                  filled: true,
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 35, horizontal: 20),
                  hintText: 'Your message',
//                  hintStyle: TextStyle(
//                    color: Colors.blueGrey,
//                    fontFamily: 'RobotoSlab',
//                  ),
                  border: unfocusedInputBorder(),
                  enabledBorder: unfocusedInputBorder(),
                  focusedBorder: focusedInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Card(
              color: Colors.green[300],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    t1.clear();
                    t2.clear();
                    t3.clear();
                    _launchURLMail(subject: subject, body: 'From $name,\n$message');
                  });
                },
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                          )),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.03,
                      ),
                      Center(
                          child: Text(
                            "Send",
                            textAlign: TextAlign.center,
//                            style: TextStyle(
//                                color: Colors.white, fontFamily: 'RobotoSlab'),
                          )),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05,
                  left: 21,
                  right: 21,
                  bottom: MediaQuery.of(context).size.height * 0.034),
              child: Text(
                "Alternatively, you can also report idea, bugs, and errors on following platforms",
                textAlign: TextAlign.center,
//                style: TextStyle(
//                  fontFamily: 'RobotoSlab',
//                  color: Colors.blueGrey[600],
//                  fontSize: 17,
//                  height: 1.3,
//                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () => launchUrl(
                      "https://github.com/BlueCobra-6/AnimalCrossingNewHorizonPriceListApp"),
                  child: Icon(
                    FontAwesomeIcons.github,
                    color: Colors.orange,
                    size: 35,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.06,
                ),
                GestureDetector(
                  onTap: () => launchUrl(
                      "https://play.google.com/store/apps/details?id=com.lifeplusapp&hl=en_IN"),
                  child: Icon(FontAwesomeIcons.googlePlay,
                      color: Color(0xFFFB3958), size: 35),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.06,
                ),
                GestureDetector(
                  onTap: () => launchUrl(
                      "https://apps.apple.com/us/app/uhc-motion/id1069385514"),
                  child: Icon(FontAwesomeIcons.appStoreIos,
                      color: Color(0xFF278DF1), size: 35),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.06,
                ),
                GestureDetector(
                  onTap: () => _launchURLMail(),
                  child: Icon(FontAwesomeIcons.at,
                      color: Color(0xFF1DA1F2), size: 35),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


}