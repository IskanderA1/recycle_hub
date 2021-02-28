import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recycle_hub/screens/main_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:recycle_hub/style/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    _checkPermissions();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
        //designSize: Size(360, 690),
        allowFontScaling: false,
        builder: () => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'RecycleHub',
              theme: kAppThemeData(),
              home: MainScreen(),
            ));
  }
}

_checkPermissions() async {
  var status = await Permission.location.status;

  /*if ((await Permission.accessMediaLocation.isUndetermined)) {
    Permission.accessMediaLocation.request();
  }*/

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
