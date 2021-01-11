import 'package:flutter/material.dart';
import 'package:recycle_hub/screens/main_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:recycle_hub/style/theme.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    _checkPermissions();
    return MaterialApp(
      title: 'RecycleHub',
      theme: kAppThemeData(),
      home: MainScreen(),
    );
  }
}

_checkPermissions() async {
  var status = await Permission.location.status;
  var status1 = await Permission.locationAlways.status;

  /*if ((await Permission.accessMediaLocation.isUndetermined)) {
    Permission.accessMediaLocation.request();
  }*/

  if (!status1.isGranted) {
    await Permission.locationAlways.request();
  }

  if (status.isUndetermined) {
    // We didn't ask for permission yet.
    await Permission.location.request();
  }

// You can can also directly ask the permission about its status.
  /*if (await Permission.location.isRestricted) {
    // The OS restricts access, for example because of parental controls.
    await Permission.location.request();
  }*/
}
