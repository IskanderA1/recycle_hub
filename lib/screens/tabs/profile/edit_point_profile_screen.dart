import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:recycle_hub/api/services/points_service.dart';
import 'package:recycle_hub/bloc/auth/auth_bloc.dart';
import 'package:recycle_hub/bloc/cubit/profile_menu_cubit.dart';
import 'package:recycle_hub/bloc/filter_type_cubit.dart';
import 'package:recycle_hub/elements/common_text_button.dart';
import 'package:recycle_hub/helpers/messager_helper.dart';
import 'package:recycle_hub/model/map_models.dart/accept_types.dart';
import 'package:recycle_hub/model/map_models.dart/marker.dart';
import 'package:recycle_hub/model/user_model.dart';
import 'package:recycle_hub/screens/tabs/map/widgets/loader_widget.dart';
import 'package:recycle_hub/elements/image_picker_container.dart';
import 'package:recycle_hub/elements/check_box_cell.dart';
import 'package:recycle_hub/elements/simple_text_field.dart';
import 'package:recycle_hub/elements/ball.dart';
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
  List<FilterType> _recycleTypes = [];
  List<FilterType> _pointRecycleTypes = [];
  bool _isLoading = false;
  UserModel _user;
  CustMarker _point;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    _user = GetIt.I.get<AuthBloc>().state.userModel;
    print('user $_user');
    print('user ${_user.userType}');
    print('user ${_user.attachedRecPointId}');

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
    print('point $point');
    if (point != null) {
      fillByPoint(point);
    }

    setState(() {
      _isLoading = false;
    });
  }

  fillByPoint(CustMarker point) {
    _point = point;
    _ppName.text = point.name;
    _ppOrgName.text = point.name;
    _ppAddress.text = point.address;
    _ppEmail..text = '';
    _ppAdminPhone.text = point.contacts.first;
    _ppPartnerPhone.text = point.contacts.first;
    _ppDescription.text = point.description;
    _recycleTypes = GetIt.I.get<FilterTypeCubit>().state;
    _pointRecycleTypes = _recycleTypes
        .where((element) => point.acceptTypes.contains(element.id))
        .toList();
    _isPayback = point.getBonus;
    try {
      _photos = point.images.map((e) => File.fromUri(Uri.parse(e))).toList();
    } catch (e) {
      _photos = [];
    }
    setState(() {});
  }

  Future<void> savePoint() async {
    setState(() {
      _isLoading = true;
    });
    try {
      CustMarker marker = _point.copyWith(
          name: _ppName?.text,
          address: _ppAddress?.text,
          acceptTypes: _pointRecycleTypes.map((e) => e.id).toList(),
          contacts: [_ppAdminPhone?.text, _ppPartnerPhone?.text],
          description: _ppDescription?.text,
          );
      await PointsService().sendPointInfo(marker, _photos);
    } catch (e) {
      AlertHelper.showMessage(context: context, message: e.toString());
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: kColorWhite,
            ),
            onPressed: () => GetIt.I.get<ProfileMenuCubit>().goBack()),
        title: Text(
          "Редактировать профиль",
          /* style: TextStyle(color: kColorWhite, fontSize: 18, fontFamily: 'GillroyMedium', fontWeight: FontWeight.bold), */
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
                    controller: scrollController,
                    shrinkWrap: true,
                    children: [
                      SimpleTextField(
                        labelText: 'Название пункта приема',
                        controller: _ppName,
                      ),
                      SimpleTextField(
                        labelText: 'Название организации',
                        controller: _ppOrgName,
                      ),
                      SimpleTextField(
                        labelText: 'Адрес пункта приема',
                        controller: _ppAddress,
                      ),
                      Text('Выдает экокоины',
                          style: Theme.of(context).textTheme.headline6),
                      Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: CheckBoxCell(
                            isSelected: _isPayback,
                            text: 'Да',
                            onTap: () {
                              setState(() {
                                _isPayback = true;
                              });
                            },
                          )),
                      Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: CheckBoxCell(
                            isSelected: !_isPayback,
                            text: 'Нет',
                            onTap: () {
                              setState(() {
                                _isPayback = false;
                              });
                            },
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text('Принимают на переработку',
                            style: Theme.of(context).textTheme.headline6),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: ListView.builder(
                            controller: scrollController,
                            shrinkWrap: true,
                            itemCount: _recycleTypes.length,
                            itemBuilder: (context, i) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: CheckBoxCell(
                                  isSelected: _pointRecycleTypes
                                      .contains(_recycleTypes[i]),
                                  text: _recycleTypes[i].name,
                                  onTap: () {
                                    if (_pointRecycleTypes
                                        .contains(_recycleTypes[i])) {
                                      _pointRecycleTypes
                                          .remove(_recycleTypes[i]);
                                    } else {
                                      _pointRecycleTypes.add(_recycleTypes[i]);
                                    }
                                    setState(() {});
                                  },
                                ),
                              );
                            }),
                      ),
                      // SimpleTextField(
                      //   labelText: 'E-mail администратора',
                      //   controller: _ppEmail,
                      // ),
                      SimpleTextField(
                        labelText: 'Телефон администратора',
                        controller: _ppAdminPhone,
                      ),
                      SimpleTextField(
                        labelText: 'Телефон партнера',
                        controller: _ppPartnerPhone,
                      ),
                      SimpleTextField(
                        labelText: 'Описание пункта приема',
                        controller: _ppDescription,
                        maxLines: 2,
                      ),
                      //ImagePickerWidget
                      ImagePickerContainer(
                        images: _photos,
                        onAdded: (img) {
                          //this._photos.add(img);
                        },
                        controller: scrollController,
                        onDelete: (img) {
                          //this._photos.remove(img);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Row(
                          children: [
                            BallGreen(),
                            Expanded(
                              child: Text(
                                'Ваш запрос будет отправлен модератору',
                                style: TextStyle(
                                    fontSize: 14, fontFamily: 'GilroyMedium'),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 80, top: 16),
                        child: CommonTextButton(
                          text: 'Сохранить изменения',
                          textColor: kColorWhite,
                          ontap: () {
                            savePoint();
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
