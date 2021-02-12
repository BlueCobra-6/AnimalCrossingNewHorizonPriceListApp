import 'dart:async';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

Widget appVersionWidget() {
  return new FutureBuilder(
      future: getAppVersion(),
      builder: (BuildContext context, AsyncSnapshot<String> text) {
        return new Text("App Version: " + text.data);
      });
}

  Future<String> getAppVersion() async {
    String appName;
    String packageName;
    String version;
    String buildNumber;
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      appName = packageInfo.appName;
      packageName = packageInfo.packageName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
    return await new Future(() => version);
  }
