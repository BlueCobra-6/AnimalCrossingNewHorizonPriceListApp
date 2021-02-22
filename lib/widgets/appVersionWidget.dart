import 'dart:async';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

Widget appVersionWidget() {
  return new FutureBuilder(
      future: getAppVersion(),
      builder: (BuildContext context, AsyncSnapshot<String> text) =>
        Text("App Version: " + (text.hasData ? text.data : "Loading..."))
      );
}

  Future<String> getAppVersion() async {
    String version;
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      version = packageInfo.version;
    });
    return await new Future(() => version);
  }
