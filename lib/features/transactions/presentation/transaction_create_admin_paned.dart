import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:menu_button/menu_button.dart';
import 'package:provider/provider.dart';
import 'package:recycle_hub/bloc/profile_bloc/profile_bloc.dart';
import 'package:recycle_hub/elements/input_style.dart';
import 'package:recycle_hub/features/transactions/domain/state/transactions_admin_panel_state.dart/transactions_admin_panel_state.dart';
import 'package:recycle_hub/helpers/filter_types.dart';
import 'package:recycle_hub/model/map_models.dart/accept_types.dart';
import 'package:recycle_hub/style/theme.dart';
import './components/drop_down_menu_button.dart';
import '../../../helpers/messager_helper.dart';
import '../../../elements/common_button.dart';
import '../../../model/garbage.dart';

class TransactionCreateAdminPanelScreen extends StatefulWidget {
  const TransactionCreateAdminPanelScreen({Key key}) : super(key: key);

  @override
  _TransactionCreateAdminPanelScreenState createState() =>
      _TransactionCreateAdminPanelScreenState();
}

class _TransactionCreateAdminPanelScreenState
    extends State<TransactionCreateAdminPanelScreen> {
  List<FilterType> filterTypes;
  var _selectedFilterType;
  TextEditingController _massTextController = TextEditingController();
  double summ = 0;
  AdminTransactionsState state;
  File image;
  @override
  void initState() {
    filterTypes = FilterTypesService().filters;
    if (filterTypes.isNotEmpty) {
      _selectedFilterType = filterTypes[0];
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    state ??= Provider.of<AdminTransactionsState>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: WillPopScope(
        onWillPop: () {
          state.toState(AdmStoreState.INIT);
        },
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: kColorWhite, size: 25),
                onPressed: () =>
                    profileMenuBloc.mapEventToState(ProfileMenuStates.MENU),
              ),
              title: Text(
                "Подтверждение приема",
                style: TextStyle(
                    color: kColorWhite,
                    fontSize: 18,
                    fontFamily: 'GillroyMedium',
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: SingleChildScrollView(
                    child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minHeight: ScreenUtil().screenHeight - 100),
                  child: Container(
                      width: double.infinity,
                      color: Color(0xFFF2F2F2),
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 25, 15, 0),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: kColorWhite,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25),
                                      topRight: Radius.circular(25))),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 0, 16, 0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 30, bottom: 5),
                                      child: Row(
                                        children: [
                                          if (_selectedFilterType != null)
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Тип вторсырья",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily:
                                                          'GilroyMedium',
                                                      color: kColorGreyLight),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8),
                                                  child: buildropDownMenu(),
                                                ),
                                              ],
                                            ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Вес",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily:
                                                          'GilroyMedium',
                                                      color: kColorGreyLight),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8),
                                                  child: Container(
                                                    height: 45,
                                                    child: TextField(
                                                      keyboardType:
                                                          TextInputType.number,
                                                      controller:
                                                          _massTextController,
                                                      decoration:
                                                          inputAdminPanelDecorWidget(),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CommonButton(
                                        text: "Добавить вторсырье",
                                        backGroundColor: kColorGreyVeryLight,
                                        ontap: () {
                                          if (_massTextController
                                              .text.isEmpty) {
                                            showMessage(
                                                context: context,
                                                message: 'Введите вес');
                                            return;
                                          }
                                          state.saveFilterAndAmmount(
                                              GarbageTupple(
                                                  filterType:
                                                      _selectedFilterType,
                                                  ammount: double.parse(
                                                      _massTextController
                                                          .text)));
                                        },
                                      ),
                                    ),
                                    Observer(
                                      builder: (context) {
                                        return ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: state.garbages.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5, bottom: 5),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text(
                                                    state.garbages[index]
                                                        .filterType.name,
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: 'Gilroy'),
                                                  ),
                                                  Text(
                                                    '${state.garbages[index].ammount}',
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: 'Gilroy'),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      state
                                                          .deleteFilterAndAmmount(
                                                              index);
                                                    },
                                                    child: Icon(
                                                      Icons.remove_circle,
                                                      color: kColorBlack,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          "Всего",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Gilroy'),
                                        ),
                                        Text(
                                          '$summ кг',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Gilroy'),
                                        ),
                                        SizedBox(),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Прикрепить фото",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'GilroyMedium',
                                                color: kColorGreyLight),
                                          )),
                                    ),
                                    image == null
                                        ? Placeholder()
                                        : Image.file(
                                            image,
                                            height: 300,
                                          ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CommonButton(
                                              height: 45,
                                              width: 150,
                                              text: "Из устройства",
                                              textColor: kColorWhite,
                                              ontap: () {}),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          CommonButton(
                                              height: 45,
                                              width: 150,
                                              backGroundColor:
                                                  kColorGreyVeryLight,
                                              text: "Камера",
                                              ontap: () {})
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 16),
                                      child: CommonButton(
                                          text: "Подтвердить прием",
                                          textColor: kColorWhite,
                                          ontap: () {
                                            if (state.garbages.isEmpty) {
                                              state.createGarbageCollection();
                                              return;
                                            }
                                            state
                                                .createGarbageCollection()
                                                .then((v) {
                                              showMessage(
                                                  context: context,
                                                  message:
                                                      "Успешно отправлено");
                                            });
                                          }),
                                    ),
                                    SizedBox(
                                      height: 100,
                                    )
                                  ],
                                ),
                              )))),
                )))),
      ),
    );
  }

  Widget buildropDownMenu() {
    return Container(
      height: 45,
      width: 200,
      /*decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15))
      ),*/
      child: MenuButton<FilterType>(
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border.all(color: kColorGreyLight, width: 1),
            borderRadius: BorderRadius.circular(10)),
        selectedItem: _selectedFilterType,
        //itemBackgroundColor: Color(0xFFF7F7F7),
        menuButtonBackgroundColor: Colors.transparent,
        child: DropDownMenuChildButton(
          selectedItem: _selectedFilterType.name,
        ),
        items: filterTypes,
        itemBuilder: (FilterType item) => Container(
          height: 45,
          color: kColorWhite,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: Text("${item.name}"),
        ),
        /*toggledChild: Container(
          child: DropDownMenuChildButton(
            selectedItem: _selectedFilterType.name,
          ),
        ),*/
        onItemSelected: (FilterType item) {
          _selectedFilterType = item;
        },
        onMenuButtonToggle: (bool isTohgle) {
          print(isTohgle);
        },
      ),
    );
  }
}
