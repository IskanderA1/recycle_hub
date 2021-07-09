import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:recycle_hub/api/profile_repository/profile_repository.dart';
import 'package:recycle_hub/bloc/auth/auth_bloc.dart';
import 'package:recycle_hub/bloc/cubit/profile_menu_cubit.dart';
import 'package:recycle_hub/bloc/eco_coin_menu/eco_coin_menu_cubit.dart';
import 'package:recycle_hub/bloc/eco_guide_cubit/eco_guide_cubit_cubit.dart';
import 'package:recycle_hub/bloc/eco_test_bloc/eco_test_bloc.dart';
import 'package:recycle_hub/bloc/map/map_bloc.dart';
import 'package:recycle_hub/bloc/nav_bar_cubit/nav_bar_cubit_cubit.dart';
import 'package:recycle_hub/bloc/recovery_bloc/recovery_bloc.dart';
import 'package:recycle_hub/bloc/registration/registration_bloc.dart';
import 'package:recycle_hub/screens/authorisation_and_registration/auth_screen.dart';
import 'package:recycle_hub/screens/main_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:recycle_hub/screens/workspace_screen.dart';
import 'package:recycle_hub/style/theme.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recycle_hub/screens/error_screen.dart';
import 'model/map_models.dart/accept_types.dart';
import 'model/map_models.dart/contact_model.dart';
import 'model/map_models.dart/coord.dart';
import 'model/map_models.dart/marker.dart';
import 'model/map_models.dart/work_day.dart';
import 'model/map_models.dart/work_time.dart';
import 'model/user_model.dart';
import 'model/transactions/user_transaction_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///total hive types next free number = 17
  ///to build models type in console
  ///flutter packages pub run build_runner build --delete-conflicting-outputs
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  //Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(CustMarkerAdapter());
  Hive.registerAdapter(WorkDayAdapter());
  Hive.registerAdapter(WorkingTimeAdapter());
  Hive.registerAdapter(ContactAdapter());
  Hive.registerAdapter(FilterTypeAdapter());
  Hive.registerAdapter(CoordsAdapter());
  //Hive.registerAdapter(TransactionAdapter());
  Hive.registerAdapter(UserTransactionAdapter());
  Hive.openBox('user');
  Hive.openBox('markers');
  GetIt.I.registerSingleton<EcoCoinMenuCubit>(EcoCoinMenuCubit());
  GetIt.I.registerSingleton<EcoGuideCubit>(EcoGuideCubit());
  GetIt.I.registerSingleton<NavBarCubit>(NavBarCubit());
  GetIt.I.registerSingleton<AuthBloc>(AuthBloc()..add(AuthEventInit()));
  GetIt.I.registerSingleton<RegistrationBloc>(RegistrationBloc());
  GetIt.I.registerSingleton<RecoveryBloc>(RecoveryBloc());
  GetIt.I.registerSingleton<MapBloc>(MapBloc());
  GetIt.I.registerSingleton<ProfileMenuCubit>(ProfileMenuCubit());
  GetIt.I.registerSingleton<EcoTestBloc>(EcoTestBloc(ProfileRepository()));
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
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'RecycleHub',
        theme: kAppThemeData(),
        initialRoute: '/',
        routes: {
          '/': (context) => MainScreen(),
          '/auth': (context) => AuthScreen(),
          '/error': (context) => ErrorScreen()
        },
      ),
    );
  }
}

_checkPermissions() async {
  var status = await Permission.location.status;
  var dataAccess = await Permission.storage.status;

  if (!dataAccess.isGranted) {
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
