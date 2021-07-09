import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:recycle_hub/api/services/points_service.dart';
import 'package:recycle_hub/api/services/user_service.dart';
import 'package:recycle_hub/bloc/auth/auth_bloc.dart';
import 'package:recycle_hub/bloc/cubit/profile_menu_cubit.dart';
import 'package:recycle_hub/model/eco_guide_models/filter_model.dart';
import 'package:recycle_hub/model/map_models.dart/marker.dart';
import 'package:recycle_hub/model/user_model.dart';
import 'package:recycle_hub/screens/tabs/map/widgets/loader_widget.dart';
import 'package:recycle_hub/style/theme.dart';

class EditPointProfileScreen extends StatefulWidget {
  @override
  _EditPointProfileScreenState createState() => _EditPointProfileScreenState();
}

class _EditPointProfileScreenState extends State<EditPointProfileScreen> {
  TextEditingController _ppName = TextEditingController();
  TextEditingController _ppOrgName = TextEditingController();
  TextEditingController _ppAddress = TextEditingController();
  TextEditingController _ppEmail = TextEditingController();
  TextEditingController _ppAdminPhone = TextEditingController();
  TextEditingController _ppPartnerPhone = TextEditingController();
  TextEditingController _ppDescription = TextEditingController();
  List<File> _photos = [];
  bool _isPayback = false;
  List<FilterModel> _recycleTypes = [];
  bool _isLoading = false;
  UserModel _user;

  @override
  void initState() {
    _user = GetIt.I.get<AuthBloc>().state.userModel;
    if (_user.userType == UserTypes.admin && _user.attachedRecPointId != null) {
      loadPoint();
    }
    super.initState();
  }

  Future<void> loadPoint() async {
    assert(_user != null, _user.attachedRecPointId != null);
    setState(() {
      _isLoading = true;
    });

    var point = await PointsService().getPoint(_user.attachedRecPointId);
    //if(point != null);;
  }

 /*  fillByPoint(CustMarker point){
    _ppName.text = point.name;
    _ppOrgName.text = point.name;
    _ppAddress.text = point.address;
    _ppEmail..text = '';
    _ppAdminPhone.text = point.contacts.first;
    _ppPartnerPhone.text = point.contacts.first;
    _ppDescription.text = point.description;
    _recycleTypes = point.acceptTypes.map((e) => PointsService().getAcceptTypes().;
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: kColorWhite, size: 25),
            onPressed: () => GetIt.I.get<ProfileMenuCubit>().goBack()),
        title: Text(
          "QR Сканнер",
          style: TextStyle(
              color: kColorWhite,
              fontSize: 18,
              fontFamily: 'GillroyMedium',
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? LoaderWidget()
          : InkWell(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: kColorWhite,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16))),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Text('Название пункта приема',
                          style: Theme.of(context).textTheme.headline6),
                      TextField(),
                      Text('Название организации',
                          style: Theme.of(context).textTheme.headline6),
                      Text('Адрес пункта приема',
                          style: Theme.of(context).textTheme.headline6),
                      Text('Выдает экокоины',
                          style: Theme.of(context).textTheme.headline6),
                      Text('Принимают на переработку',
                          style: Theme.of(context).textTheme.headline6),
                      Text('E-mail администратора',
                          style: Theme.of(context).textTheme.headline6),
                      Text('Телефон администратора',
                          style: Theme.of(context).textTheme.headline6),
                      Text('Телефон партнера',
                          style: Theme.of(context).textTheme.headline6),
                      Text('Описание пункта приема',
                          style: Theme.of(context).textTheme.headline6),
                      //ImagePickerWidget
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
