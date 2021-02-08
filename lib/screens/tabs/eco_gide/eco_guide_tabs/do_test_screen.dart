import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recycle_hub/bloc/eco_guide_blocs/eco_menu_bloc.dart';

import '../../../../style/theme.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Пройти Тест"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_sharp),
          onPressed: () {
            ecoMenu.backToMenu();
          },
        ),
      ),
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 10,
              ),
              SvgPicture.asset("svg/test_illustration.svg"),
              SizedBox(
                height: 10,
              ),
              Text(
                "К факторам экосистемы относятся:",
                style: TextStyle(
                    color: kColorBlack,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Container(
                        height: 50,
                        margin: EdgeInsets.only(bottom: 7),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border:
                                Border.all(color: Color(0xFFC9C9C9), width: 2)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Color(0xFFC9C9C9), width: 2)),
                              child: Text(
                                "A",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text("совокупность живого вещества"),
                          ],
                        )),
                    Container(
                        height: 50,
                        margin: EdgeInsets.only(bottom: 7),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border:
                                Border.all(color: Color(0xFFC9C9C9), width: 2)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Color(0xFFC9C9C9), width: 2)),
                              child: Text(
                                "B",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text("атмосферный, гидросферный"),
                          ],
                        )),
                    Container(
                        height: 50,
                        margin: EdgeInsets.only(bottom: 7),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border:
                                Border.all(color: Color(0xFFC9C9C9), width: 2)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Color(0xFFC9C9C9), width: 2)),
                              child: Text(
                                "C",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text("биогенный, абиогенный"),
                          ],
                        )),
                    Container(
                        height: 50,
                        margin: EdgeInsets.only(bottom: 7),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border:
                                Border.all(color: Color(0xFFC9C9C9), width: 2)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Color(0xFFC9C9C9), width: 2)),
                              child: Text(
                                "D",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text("гидросферный и биосферный"),
                          ],
                        )),
                  ],
                ),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: RaisedButton(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              padding: EdgeInsets.all(15),
              color: Color(0xFF249507),
              onPressed: () {},
              child: Center(
                child: Text(
                  "Продолжить",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
