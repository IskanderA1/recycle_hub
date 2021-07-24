
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_button/menu_button.dart';
import 'package:recycle_hub/bloc/marker_edit_cubit/marker_edit_cubit.dart';
import 'package:recycle_hub/features/transactions/presentation/components/drop_down_menu_button.dart';
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

  String selectedReportType = '';

  var reportsType = <String>[
    'Название пункта приема',
    'Адрес',
    'Время работы',
    'Контакты',
    'Выдача экокоинов',
    'Принимаемые отходы',
    'Другое',
  ];

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
      body: GestureDetector(
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
                      "Опишите в чем ошибка\n"
                      "и выберите тип",
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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15, right: 100),
                      child: Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              child: MenuButton<String>(
                                decoration: BoxDecoration(
                                  color: Color(0xFFF7F7F7),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                selectedItem: selectedReportType,
                                itemBackgroundColor: Color(0xFFF7F7F7),
                                menuButtonBackgroundColor: Color(0xFFF7F7F7),
                                child: DropDownMenuChildButton(
                                  selectedItem: selectedReportType.isEmpty
                                      ? 'Нажмите чтобы'
                                      : selectedReportType,
                                ),
                                items: reportsType,
                                itemBuilder: (String item) => Container(
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF7F7F7),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 0,
                                    horizontal: 20,
                                  ),
                                  child: Text(item),
                                ),
                                toggledChild: Container(
                                  child: DropDownMenuChildButton(
                                    selectedItem: selectedReportType,
                                    width: 200,
                                  ),
                                ),
                                onItemSelected: (String item) {
                                  setState(() {
                                    selectedReportType = item;
                                  });
                                },
                                onMenuButtonToggle: (bool isTohgle) {
                                  print(isTohgle);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                            await Future.delayed(Duration(milliseconds: 2500));
                            Navigator.pop(context);
                          }
                        },
                        builder: (context, state) {
                          return InkWell(
                            onTap: state.isLoading
                                ? null
                                : () {
                                    if (selectedReportType.isNotEmpty &&
                                        _reportController.text.isNotEmpty) {
                                      _cubit.updateMarker(
                                        reportText: _reportController.text,
                                        reportType: selectedReportType,
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
