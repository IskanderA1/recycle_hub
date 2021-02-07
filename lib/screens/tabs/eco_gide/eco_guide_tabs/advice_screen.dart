import 'package:flutter/material.dart';
import 'package:recycle_hub/bloc/eco_guide_blocs/eco_menu_bloc.dart';
import 'advice_details.dart';
import '../../../../style/theme.dart';

class AdviceScreen extends StatefulWidget {
  @override
  _AdviceScreenState createState() => _AdviceScreenState();
}

class _AdviceScreenState extends State<AdviceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Советы для экономики"),
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
          children: [
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              margin: EdgeInsets.only(bottom: 10),
              child: Column(
                children: [
                  Container(
                    child: Wrap(
                      spacing: 5,
                      children: [
                        Container(
                          child: RaisedButton(
                            elevation: 0,
                            color: Colors.grey[300],
                            textColor: Colors.black,
                            disabledTextColor: Colors.white,
                            highlightColor: Color(0xFF249507),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            onPressed: () {},
                            child: Text("Все"),
                          ),
                        ),
                        Container(
                          child: RaisedButton(
                            elevation: 0,
                            color: Colors.grey[300],
                            highlightColor: Color(0xFF249507),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            onPressed: () {},
                            child: Text("Утилизация"),
                          ),
                        ),
                        Container(
                          child: RaisedButton(
                            elevation: 0,
                            color: Colors.grey[300],
                            highlightColor: Color(0xFF249507),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            onPressed: () {},
                            child: Text("Экономика"),
                          ),
                        ),
                        Container(
                          child: RaisedButton(
                            elevation: 0,
                            color: Colors.grey[300],
                            highlightColor: Color(0xFF249507),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            onPressed: () {},
                            child: Text("Электричество"),
                          ),
                        ),
                        Container(
                          child: RaisedButton(
                            elevation: 0,
                            color: Colors.grey[300],
                            highlightColor: Color(0xFF249507),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            onPressed: () {},
                            child: Text("Экономика"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey[200],
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              height: MediaQuery.of(context).size.height - 277,
              child: ListView(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return AdviceDetails();
                        },
                      ));
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      height: 400,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Expanded(
                                child: Hero(
                              tag: "first_image",
                              child: Image.network(
                                  "https://www.accenture.com/t20200128T032529Z__w__/lu-en/_acnmedia/Accenture/Redesign-Assets/DotCom/Images/Global/Thumbnail400x400/8/Accenture-australian-water-utility-blue-400x400.jpg"),
                            )),
                            Expanded(
                                child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Text(
                                    "Как и зачем экономить воду?",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Wrap(children: [
                                    Text(
                                        "  Вода – незаменимый источник существования каждого человека. Однако неэкономное использованиеэтого незаменимого и важного ресурса, в большинстве странах, может привести к нарушению стабильности в экосистемах...")
                                  ]),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "19.01.2021",
                                        style:
                                            TextStyle(color: kColorGreyLight),
                                      ),
                                      Text(
                                        "Поподробнее",
                                        style:
                                            TextStyle(color: kColorGreyLight),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ))
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    height: 400,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Expanded(
                              child: Hero(
                            tag: "first image",
                            child: Image.network(
                                "https://www.accenture.com/t20200128T032529Z__w__/lu-en/_acnmedia/Accenture/Redesign-Assets/DotCom/Images/Global/Thumbnail400x400/8/Accenture-australian-water-utility-blue-400x400.jpg"),
                          )),
                          Expanded(
                              child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Hero(
                                  tag: "first title",
                                  child: Text(
                                    "Как и зачем экономить воду?",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Wrap(children: [
                                  Text(
                                      "  Вода – незаменимый источник существования каждого человека. Однако неэкономное использованиеэтого незаменимого и важного ресурса, в большинстве странах, может привести к нарушению стабильности в экосистемах...")
                                ]),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "19.01.2021",
                                      style: TextStyle(color: kColorGreyLight),
                                    ),
                                    Text(
                                      "Поподробнее",
                                      style: TextStyle(color: kColorGreyLight),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
