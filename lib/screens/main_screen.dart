import 'package:flutter/material.dart';
import 'package:recycle_hub/bloc/auth_user_bloc.dart';
import 'package:recycle_hub/elements/loader.dart';
import 'package:recycle_hub/model/user_response.dart';
import 'package:recycle_hub/screens/auth_screen.dart';
import 'package:recycle_hub/screens/workspace_screen.dart';
import 'package:recycle_hub/style/style.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final loginController = TextEditingController();
  final passController = TextEditingController();

  @override
  void initState() {
    authBloc.authLocal();
    super.initState();
  }

  @override
  void dispose() {
    authBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.mainColor,
      body: StreamBuilder(
          stream: authBloc.subject,
          // ignore: missing_return
          builder: (context, AsyncSnapshot<UserResponse> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.error != null &&
                  snapshot.data.error.length > 0) {
                if (snapshot.data.error == "Loading") {
                  return buildLoadingWidget();
                }
                if (snapshot.data.error == "Авторизуйтесь") {
                  //TODO: Заменить на AuthScreen после того как сделаем 
                  return WorkSpaceScreen();
                }
                 //TODO: Заменить на AuthScreen после того как сделаем 
                return WorkSpaceScreen();
              }

              return Center(
                child: WorkSpaceScreen(),
              );
            } else if (snapshot.hasError) {
               //TODO: Заменить на AuthScreen после того как сделаем 
              return WorkSpaceScreen();
            } else {
              return buildLoadingWidget();
            }
          }),
    );
  }
}
