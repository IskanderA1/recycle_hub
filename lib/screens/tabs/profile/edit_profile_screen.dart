import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:recycle_hub/api/services/user_service.dart';
import 'package:recycle_hub/bloc/cubit/profile_menu_cubit.dart';
import 'package:recycle_hub/elements/user_image_picker.dart';
import 'package:recycle_hub/helpers/messager_helper.dart';
import 'package:recycle_hub/model/user_model.dart';
import 'package:recycle_hub/screens/tabs/map/widgets/loader_widget.dart';
import 'package:recycle_hub/style/style.dart';
import 'package:recycle_hub/style/theme.dart';

enum Gender { MAN, WOMAN }

class EditProfileScreen extends StatefulWidget {
  UserModel user;
  EditProfileScreen({this.user});
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController _name = TextEditingController();
  TextEditingController _surname = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _age = TextEditingController();
  TextEditingController _address = TextEditingController();
  Gender _gender = Gender.MAN;
  bool _isMan = true;
  bool _isLoading = false;

  @override
  initState() {
    _name.text = widget.user != null ? widget.user.name : '';
    super.initState();
  }

  Future<void> _saveUser() async {
    setState(() {
      _isLoading = true;
    });

    if (_name.text.isNotEmpty) {
      try {
        await UserService().saveUserInfo(name: _name.text);
        GetIt.I.get<ProfileMenuCubit>().goBack();
      } on Exception catch (e) {
        showMessage(
          context: context,
          message: e.toString(),
        );
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWhite,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Редактировать профиль",
          style: TextStyle(fontFamily: 'Gillroy'),
        ),
        leading: GestureDetector(
          onTap: () {
            GetIt.I.get<ProfileMenuCubit>().goBack();
          },
          child: Icon(
            Icons.arrow_back,
            color: kColorWhite,
            size: 25,
          ),
        ),
      ),
      body: _isLoading
          ? Center(
              child: LoaderWidget(),
            )
          : SingleChildScrollView(
              child: InkWell(
                onTap: () => FocusScope.of(context).unfocus(),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 30, bottom: 15),
                            child: UserImagePicker(
                              image: widget.user != null
                                  ? widget.user.image
                                  : null,
                            ),
                          ),
                          /* Padding(
                            padding: EdgeInsets.only(top: 30, bottom: 15),
                            child: Container(
                              height: 100,
                              width: 100,
                              child: Stack(
                                children: [
                                  Container(
                                      height: 100,
                                      width: 100,
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            "https://idsb.tmgrup.com.tr/ly/uploads/images/2020/04/30/33310.jpg"),
                                      )),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 5, bottom: 5),
                                      child: GestureDetector(
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xFFF2F2F2)),
                                          child: Center(
                                            child: Icon(
                                              Icons.edit,
                                              color: kColorGreen,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ), */
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: EditProfileScreenTextField(
                              controller: _name,
                              hintText: "Имя",
                              adText: "Имя",
                              type: TextInputType.name,
                            ),
                          ),
                          /* Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: EditProfileScreenTextField(
                              controller: _surname,
                              hintText: "Фамилия",
                              adText: "Фамилия",
                              type: TextInputType.name,
                            ),
                          ), */
                          /* Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: EditProfileScreenTextField(
                        controller: _email,
                        hintText: "E-mail",
                        adText: "E-mail",
                        type: TextInputType.emailAddress,
                      ),
                    ), */
                          /*  Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: EditProfileScreenTextField(
                              controller: _password,
                              hintText: "Пароль",
                              adText: "Пароль",
                              type: TextInputType.visiblePassword,
                            ),
                          ), */
                          /* Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: EditProfileScreenTextField(
                        controller: _age,
                        hintText: "Возраст",
                        adText: "Возраст",
                        type: TextInputType.number,
                      ),
                    ), */
                          //GENDER
                          /* Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(30, 10, 0, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Ваш пол",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF8D8D8D)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _isMan = !_isMan;
                                        });
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            color: _isMan
                                                ? kColorGreen
                                                : kColorWhite,
                                            border: Border.all(
                                                color: !_isMan
                                                    ? kColorGreyDark
                                                    : kColorGreen,
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.all(
                                                    Radius.circular(8))),
                                        child: Icon(
                                          Icons.check_outlined,
                                          size: 20,
                                          color: kColorWhite,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: const Text(
                                        "Мужчина",
                                        style: TextStyle(
                                            color: kColorBlack,
                                            fontFamily: 'GillroyMedium',
                                            fontSize: 14),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _isMan = !_isMan;
                                        });
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            color: !_isMan
                                                ? kColorGreen
                                                : kColorWhite,
                                            border: Border.all(
                                                color: _isMan
                                                    ? kColorGreyDark
                                                    : kColorGreen,
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.all(
                                                    Radius.circular(8))),
                                        child: Icon(
                                          Icons.check_outlined,
                                          size: 20,
                                          color: kColorWhite,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: const Text(
                                        "Женщина",
                                        style: TextStyle(
                                            color: kColorBlack,
                                            fontFamily: 'GillroyMedium',
                                            fontSize: 14),
                                      ),
                                    )
                                  ],
                                ),
                              )
                              /*ListTile(
                                title: const Text(
                                  "Мужчина",
                                  style: TextStyle(
                                      color: kColorBlack,
                                      fontFamily: 'GillroyMedium',
                                      fontSize: 14),
                                ),
                                leading: Radio<Gender>(
                                  groupValue: _gender,
                                  onChanged: (Gender g) {
                                    setState(() {
                                      _gender = g;
                                    });
                                  },
                                  value: Gender.MAN,
                                ),
                              ),
                              ListTile(
                                title: const Text(
                                  "Женщина",
                                  style: TextStyle(
                                      color: kColorBlack,
                                      fontFamily: 'GillroyMedium',
                                      fontSize: 14),
                                ),
                                leading: Radio<Gender>(
                                  groupValue: _gender,
                                  onChanged: (Gender g) {
                                    setState(() {
                                      _gender = g;
                                    });
                                  },
                                  value: Gender.WOMAN,
                                ),
                              )*/
                            ],
                          )),
                    ), */
                          /* Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: EditProfileScreenTextField(
                        controller: _address,
                        hintText: "Адрес",
                        adText: "Домашний адрес",
                        type: TextInputType.number,
                      ),
                    ), */
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              _saveUser();
                            },
                            child: Container(
                              width: 300,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: kColorGreen,
                                  boxShadow: [BoxShadow(color: kColorGreyDark)],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: Center(
                                child: Text("Сохранить изменения",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: kColorWhite,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'GillroyMedium')),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 100,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}

class EditProfileScreenTextField extends StatelessWidget {
  const EditProfileScreenTextField(
      {Key key,
      @required TextEditingController controller,
      @required this.hintText,
      @required this.adText,
      @required this.type})
      : _controller = controller,
        super(key: key);

  final TextEditingController _controller;
  final String hintText;
  final String adText;
  final TextInputType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            adText,
            style: TextStyle(fontSize: 14, color: Color(0xFF8D8D8D)),
          ),
          SizedBox(height: 15.0),
          Container(
            alignment: Alignment.centerLeft,
            height: 45.0,
            child: TextField(
              controller: _controller,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                color: kColorBlack,
                fontFamily: 'Gilroy',
                fontSize: 16,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: const Color(0xFFECECEC).withOpacity(0.5),
                        width: 1)),
                contentPadding: EdgeInsets.only(left: 15),
                hintText: hintText,
                hintStyle: kHintTextStyle,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
