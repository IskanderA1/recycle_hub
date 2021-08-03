import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recycle_hub/bloc/marker_edit_cubit/marker_edit_cubit.dart';
import 'package:recycle_hub/helpers/image_picker.dart';
import 'package:recycle_hub/helpers/messager_helper.dart';
import 'package:recycle_hub/main.dart';
import 'package:recycle_hub/style/style.dart';
import 'package:recycle_hub/style/theme.dart';

class ReportToErrorMarkerScreen extends StatefulWidget {
  final String markerPointID;
  const ReportToErrorMarkerScreen(
    this.markerPointID, {
    Key key,
  }) : super(key: key);
  @override
  _ReportToErrorMarkerScreenState createState() =>
      _ReportToErrorMarkerScreenState();
}

class _ReportToErrorMarkerScreenState extends State<ReportToErrorMarkerScreen> {
  final _cubit = locator<MarkerEditCubit>();
  final TextEditingController _reportController = TextEditingController();

  File _image;
  final picker = ImagePicker();

  Future _getImage() async {
    try {
      final img = await FilePicker.getImage();
      setState(() {
        _image = img;
      });
    } catch (e) {}
  }

  Future _getImageFromStorage() async {
    try {
      final img = await FilePicker.getImageFromStorage();
      setState(() {
        _image = img;
      });
    } catch (e) {}
  }

  @override
  void dispose() {
    _cubit.close();
    _reportController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorGreyVeryLight,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Сообщить об ошибке",
          style: TextStyle(fontFamily: 'Gillroy'),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: kColorWhite,
            size: 35,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
            child: Container(
              decoration: BoxDecoration(
                color: kColorWhite,
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 20, 25, 25),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Опишите в чем ошибка и приложите "
                        "фото, если требуется",
                        style: TextStyle(
                          fontFamily: 'Gillroy',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        child: ReportMarkerTextFields(
                          reportController: _reportController,
                          hintText: "Не верно указано...",
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Тип ошибки:',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF8D8D8D),
                          ),
                        ),
                      ),
                      _image != null
                          ? Image.file(
                              _image,
                              fit: BoxFit.scaleDown,
                              frameBuilder: (context, child, frame,
                                  wasSynchronouslyLoaded) {
                                if (wasSynchronouslyLoaded ?? false) {
                                  return child;
                                }
                                return AnimatedOpacity(
                                  child: Stack(
                                    children: <Widget>[
                                      child,
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Padding(
                                          padding: EdgeInsets.all(25),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _image = null;
                                              });
                                            },
                                            child: Icon(Icons.close),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  opacity: frame == null ? 0 : 1,
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.easeOut,
                                );
                              },
                            )
                          : Container(),
                      Center(
                        child: Text(
                          "Добавить фото",
                          style: TextStyle(
                              fontFamily: 'GillroyMedium',
                              fontSize: 16,
                              color: Color(0xFF8D8D8D)),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () => _getImageFromStorage(),
                              child: Container(
                                height: 45,
                                width: 140,
                                decoration: BoxDecoration(
                                    color: kColorGreen,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Center(
                                  child: Text(
                                    "Из галереи",
                                    style: TextStyle(
                                        color: kColorWhite,
                                        fontFamily: 'GillroyMedium',
                                        fontSize: 14),
                                  ),
                                ),
                              )),
                          Spacer(),
                          GestureDetector(
                              onTap: () => _getImage(),
                              child: Container(
                                height: 45,
                                width: 140,
                                decoration: BoxDecoration(
                                    color: const Color(0xFFECECEC),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Center(
                                  child: Text(
                                    "Камера",
                                    style: TextStyle(
                                        color: kColorBlack,
                                        fontFamily: 'GillroyMedium',
                                        fontSize: 14),
                                  ),
                                ),
                              ))
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                              color: kColorGreen,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Ваш запрос будет отправлен администратору",
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'GillroyMedium',
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      BlocConsumer<MarkerEditCubit, MarkerEditState>(
                          bloc: _cubit,
                          listener: (context, state) async {
                            if (state.error != null) {
                              showMessage(
                                context: context,
                                message: 'Ошибка: ${state.error}',
                              );
                            }
                            if (state.error == null && !state.isLoading) {
                              showMessage(
                                context: context,
                                message: 'Успешно',
                                backColor: kColorGreen,
                              );
                              await Future.delayed(
                                  Duration(milliseconds: 2500));
                              Navigator.pop(context);
                            }
                          },
                          builder: (context, state) {
                            return InkWell(
                              onTap: state.isLoading
                                  ? null
                                  : () {
                                      if (_reportController.text.isNotEmpty) {
                                        _cubit.updateMarker(
                                          markerId: widget.markerPointID,
                                          reportText: _reportController.text,
                                          image: _image,
                                        );
                                      }
                                    },
                              child: Container(
                                width: 300,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: kColorGreen,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                child: Center(
                                  child: !state.isLoading
                                      ? Text(
                                          "Отправить",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: kColorWhite,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'GillroyMedium',
                                          ),
                                        )
                                      : Container(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              Colors.white,
                                            ),
                                            strokeWidth: 2,
                                          ),
                                        ),
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ReportMarkerTextFields extends StatelessWidget {
  const ReportMarkerTextFields({
    Key key,
    @required this.reportController,
    @required this.hintText,
  }) : super(key: key);

  final TextEditingController reportController;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: reportController,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        color: kColorBlack,
        fontFamily: 'Gilroy',
        fontSize: 16,
      ),
      maxLines: 7,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: const Color(0xFFECECEC), width: 1),
        ),
        contentPadding: EdgeInsets.fromLTRB(15, 20, 15, 20),
        hintText: hintText,
        hintStyle: kHintTextStyle,
      ),
      textAlign: TextAlign.left,
    );
  }
}
