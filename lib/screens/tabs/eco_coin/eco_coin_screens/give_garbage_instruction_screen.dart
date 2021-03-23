import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recycle_hub/bloc/eco_coin_bloc.dart/eco_coin_menu_bloc.dart';
import 'package:recycle_hub/style/theme.dart';

class GiveGarbageInstructionScreen extends StatefulWidget {
  @override
  _GiveGarbageInstructionScreenState createState() =>
      _GiveGarbageInstructionScreenState();
}

class _GiveGarbageInstructionScreenState
    extends State<GiveGarbageInstructionScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => ecoCoinMenuBloc.pickState(EcoCoinMenuItems.MENU),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Добавить пункт приема",
            style: TextStyle(fontFamily: 'Gillroy'),
          ),
          leading: GestureDetector(
            onTap: () {
              ecoCoinMenuBloc.pickState(EcoCoinMenuItems.MENU);
            },
            child: Icon(
              Icons.arrow_back,
              color: kColorWhite,
              size: 35,
            ),
          ),
        ),
        backgroundColor: kColorGreyVeryLight,
        body: Padding(
          padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
          child: Container(
            height: ScreenUtil().screenHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: kColorWhite,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 100),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    RichText(
                      text: TextSpan(
                          text:
                              "1. Сдавайте макулатуры в пункт приема и покажите сгенерированный в личном кабинете Qr-код партнеру 2. Партнер в лице пункта приема открывает свой личный кабинет, вводит данные о сданном макулатуры, сканирует ваш код 3. Система начисляет вам 10 Экокоинов за 1кг сданной макулатуры. Также вы, получитереальные деньги от пункта вне рамок проекта, если пункт выплачивает вознаграждение за вторсырье4. Чтобы потратить Экокоинов, вам необходимо ответить на вопросы из образовательного блока. За один правильный ответ система позволяет разблокировать 10 Экокоинов. 5. Тратьте накопленные баллы у партнеров на их продукцию/услуги",
                          style: TextStyle(color: kColorBlack)),
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
