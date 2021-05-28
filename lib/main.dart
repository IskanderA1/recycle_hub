import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:recycle_hub/screens/main_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:recycle_hub/style/theme.dart';
import 'package:path_provider/path_provider.dart';
import 'model/map_models.dart/accept_types.dart';
import 'model/map_models.dart/contact_model.dart';
import 'model/map_models.dart/coord.dart';
import 'model/map_models.dart/marker.dart';
import 'model/map_models.dart/work_day.dart';
import 'model/map_models.dart/work_time.dart';
import 'model/user_model.dart';
import 'model/transactions/transaction_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ///total hive types next free number = 16
  ///to build models type in console
  ///flutter packages pub run build_runner build --delete-conflicting-outputs
  Directory directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(CustMarkerAdapter());
  Hive.registerAdapter(WorkDayAdapter());
  Hive.registerAdapter(WorkingTimeAdapter());
  Hive.registerAdapter(ContactAdapter());
  Hive.registerAdapter(AcceptTypeAdapter());
  Hive.registerAdapter(CoordsAdapter());
  Hive.registerAdapter(TransactionModelAdapter());
  Hive.openBox('user');
  Hive.openBox('markers');
  runApp(
    MyApp(),
  );
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
      //allowFontScaling: false,
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'RecycleHub',
        theme: kAppThemeData(),
        home: MainScreen(),
      ),
    );
  }
}

_checkPermissions() async {
  var status = await Permission.location.status;
  var dataAccess = await Permission.storage.status;

  if(!dataAccess.isGranted){
    await Permission.storage.request();
  }
  /*if ((await Permission.accessMediaLocation.isUndetermined)) {
    Permission.accessMediaLocation.request();
  }*/

  if (!status.isGranted) {
    // We didn't ask for permission yet.
    await Permission.location.request();
  }


// You can can also directly ask the permission about its status.
  /*if (await Permission.location.isRestricted) {
    // The OS restricts access, for example because of parental controls.
    await Permission.location.request();
  }*/
}
