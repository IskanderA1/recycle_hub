import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:recycle_hub/bloc/eco_guide_blocs/button_switch_bloc.dart';
import 'package:recycle_hub/bloc/eco_guide_blocs/eco_menu_bloc.dart';
import 'package:recycle_hub/bloc/eco_guide_blocs/trash_details_bloc.dart';
import 'package:recycle_hub/bloc/eco_guide_cubit/eco_guide_cubit_cubit.dart';
import 'package:recycle_hub/elements/loader.dart';
import 'package:recycle_hub/model/eco_guide_models/filter_response.dart';
import 'package:recycle_hub/model/map_models.dart/accept_types.dart';
import '../../../../bloc/eco_guide_blocs/trash_details_bloc.dart';
import '../../../../style/theme.dart';

List<SvgPicture> containerImages = [
  SvgPicture.asset("svg/blue_container.svg"),
  SvgPicture.asset("svg/yellow_container.svg"),
  SvgPicture.asset("svg/green_container.svg"),
  SvgPicture.asset("svg/red_container.svg"),
  SvgPicture.asset("svg/black_container.svg")
];

List<String> containerTitles = [
  "Бумага",
  "Пластик",
  "Стекло",
  "Мусор",
  "Отходы"
];

List<Tab> tabList = [];

class ContainerScreen extends StatefulWidget {
  @override
  _ContainerScreenState createState() => _ContainerScreenState();
}

class _ContainerScreenState extends State<ContainerScreen> {
  @override
  void initState() {
    trashDetailsBloc.getFilters();
    tabList = [];
    _buildTabList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Что в какой контейнер",
            style: TextStyle(),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_sharp),
            onPressed: () {
              GetIt.I.get<EcoGuideCubit>().goBack();
            },
          ),
        ),
        body: DefaultTabController(
            length: 5,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Material(
                    color: Colors.transparent,
                    child: TabBar(
                      indicatorColor: kColorGreen,
                      indicatorWeight: 3,
                      indicatorSize: TabBarIndicatorSize.label,
                      isScrollable: true,
                      tabs: tabList,
                    ),
                  ),
                ),
                Expanded(
                    child: TabBarView(
                  children: [
                    _buildContainerView(0),
                    _buildContainerView(1),
                    _buildContainerView(2),
                    _buildContainerView(3),
                    _buildContainerView(4),
                  ],
                ))
              ],
            )));
  }
}

class _buildContainerView extends StatelessWidget {
  int screenIndex;
  _buildContainerView(int screenIndex) {
    this.screenIndex = screenIndex;
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: trashDetailsBloc.containerController.stream,
        builder: (context, AsyncSnapshot<FilterResponse> snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data.filterModels[0].name);
            if (snapshot.data.error != null && snapshot.data.error.length > 0) {
              if (snapshot.data.error == "Авторизуйтесь") {
                return Center(
                  child: Text("Авторизуйтесь"),
                );
              } else {
                return Center(
                  child: Text("Ошибка: ${snapshot.data.error}"),
                );
              }
            }
            return _buildContainerList(snapshot.data, screenIndex);
          } else if (snapshot.hasError) {
            return Container();
          } else {
            return buildLoadingWidget();
          }
        });
  }
}

Widget _buildContainerList(FilterResponse filterResponse, int screenIndex) {
  List<FilterType> filterModels = filterResponse.filterModels;
  print(filterModels[0].name);
  return StreamBuilder(
      stream: switchButtonBloc.switchButtonController.stream,
      initialData: switchButtonBloc.defaultStateButton,
      builder: (context, AsyncSnapshot<StateButtons> snapshot) {
        return Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                switchButtonBloc.pickWeek(0);
                              },
                              child: Container(
                                child: Align(
                                  child: Text(
                                    "Можно",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w100,
                                        color: kColorGreyLight),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 1,
                              width: 65,
                              child: Container(
                                color: snapshot.data == StateButtons.FORBIDDEN
                                    ? Colors.transparent
                                    : kColorGreen,
                              ),
                            )
                          ],
                        ),
                        Container(
                          width: 1,
                          height: 15,
                          margin: EdgeInsets.only(left: 5, right: 5),
                          color: kColorGreyLight,
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                switchButtonBloc.pickWeek(1);
                              },
                              child: Container(
                                child: Align(
                                  child: Text(
                                    "Нельзя",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w100,
                                        color: kColorGreyLight),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 1,
                              width: 65,
                              child: Container(
                                color: snapshot.data == StateButtons.ALLOWED
                                    ? Colors.transparent
                                    : Colors.red[600],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return StreamBuilder(
                                  stream: trashDetailsBloc
                                      .containerController.stream,
                                  builder: (context, AsyncSnapshot snapshot) {
                                    FilterResponse filterResponse =
                                        snapshot.data;
                                    if (snapshot.hasData) {
                                      SvgPicture svgPicture =
                                          containerImages[screenIndex];
                                      return AlertDialog(
                                        actionsPadding: EdgeInsets.all(0),
                                        titlePadding: EdgeInsets.all(0),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        title: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(5),
                                              topRight: Radius.circular(5)),
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            height: 80,
                                            color: kColorGreen,
                                            child: svgPicture,
                                          ),
                                        ),
                                        content: Container(
                                          height: 250,
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 200,
                                                child: ListView(
                                                  children: [
                                                    Text(
                                                      "Подлежат:",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Wrap(
                                                      children: [
                                                        Text(
                                                          buildText(
                                                              filterResponse,
                                                              screenIndex)[0],
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text("Не подлежат:",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Wrap(
                                                      children: [
                                                        Text(
                                                          buildText(
                                                              filterResponse,
                                                              screenIndex)[1],
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 250,
                                                child: RaisedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  color: kColorGreen,
                                                  child: Text(
                                                    "Понятно",
                                                    style: TextStyle(
                                                        color: kColorWhite),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  });
                            },
                          );
                        },
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          Icons.contact_support,
                          size: 40,
                          color: kColorGreen,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              _buildContainerListView(filterModels, snapshot.data, screenIndex)
            ],
          ),
        );
      });
}

class _buildContainerListView extends StatelessWidget {
  List<FilterType> filterModels;
  StateButtons stateButtons;
  int screenIndex;
  Widget properties;
  _buildContainerListView(List<FilterType> filterModels,
      StateButtons stateButtons, int screenIndex) {
    this.filterModels = filterModels;
    this.stateButtons = stateButtons;
    this.screenIndex = screenIndex;
    this.properties = stateButtons == StateButtons.ALLOWED
        ? AllowedItems(filterModels[screenIndex].keyWords)
        : ForbiddenItems(filterModels[screenIndex].badWords);
    print(filterModels[screenIndex].keyWords[0]);
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 8.0),
              child: Text(
                containerTitles[screenIndex],
                style: TextStyle(fontSize: 50, color: kColorBlack),
              ),
            ),
            properties
          ],
        ),
      ],
    );
  }
}

class AllowedItems extends StatelessWidget {
  List<String> allowedItems;
  AllowedItems(List<String> allowedItems) {
    this.allowedItems = allowedItems;
    print(allowedItems[0]);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      padding: EdgeInsets.only(left: 20, top: 10, right: 20),
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      height: MediaQuery.of(context).size.height - 400,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: _buildAllowedItems(allowedItems),
      ),
    );
  }
}

class ForbiddenItems extends StatelessWidget {
  List<String> forbiddenItems;
  ForbiddenItems(List<String> forbiddenItems) {
    this.forbiddenItems = forbiddenItems;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Color(0xFFF14343),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      padding: EdgeInsets.only(left: 20, top: 10, right: 20),
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      height: MediaQuery.of(context).size.height - 400,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: ListView(
          children: _buildForbiddenItems(forbiddenItems),
        ),
      ),
    );
  }
}

List<Widget> _buildAllowedItems(List<String> allowedItems) {
  List<Widget> listItems = List<Widget>();
  print(allowedItems[0]);
  for (int i = 0; i < allowedItems.length; i += 2) {
    listItems.add(Row(
      children: [
        Expanded(
          child: Container(
            height: 125,
            margin: EdgeInsets.only(right: 2),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    maxRadius: 30,
                    backgroundColor: Colors.orange,
                    child: Text(
                      "S",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Wrap(children: [
                      Text(
                        allowedItems[i],
                        textAlign: TextAlign.center,
                      )
                    ]),
                  )
                ],
              ),
            ),
          ),
        ),
        (i + 1 < allowedItems.length)
            ? Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 2),
                  height: 125,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          maxRadius: 30,
                          backgroundColor: Colors.orange,
                          child: Text(
                            "S",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Center(
                          child: Wrap(children: [
                            Text(
                              allowedItems[i + 1],
                              textAlign: TextAlign.center,
                            )
                          ]),
                        )
                      ],
                    ),
                  ),
                ),
              )
            : Container()
      ],
    ));
  }
  return listItems;
}

List<Widget> _buildForbiddenItems(List<String> forbiddenItems) {
  List<Widget> listItems = List<Widget>();
  for (int i = 0; i < forbiddenItems.length; i += 2) {
    listItems.add(Row(
      children: [
        Expanded(
          child: Container(
            height: 125,
            margin: EdgeInsets.only(right: 2),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    maxRadius: 30,
                    backgroundColor: Colors.orange,
                    child: Text(
                      "S",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Wrap(children: [
                      Text(
                        forbiddenItems[i],
                        textAlign: TextAlign.center,
                      )
                    ]),
                  )
                ],
              ),
            ),
          ),
        ),
        (i + 1 < forbiddenItems.length)
            ? Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 2),
                  height: 125,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          maxRadius: 30,
                          backgroundColor: Colors.orange,
                          child: Text(
                            "S",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Center(
                          child: Wrap(children: [
                            Text(
                              forbiddenItems[i + 1],
                              textAlign: TextAlign.center,
                            )
                          ]),
                        )
                      ],
                    ),
                  ),
                ),
              )
            : Container()
      ],
    ));
  }
  return listItems;
}

void _buildTabList() {
  for (int i = 0; i < containerTitles.length; i++) {
    tabList.add(new Tab(
      iconMargin: EdgeInsets.all(2),
      text: containerTitles[i],
      icon: Container(
        width: 52,
        height: 52,
        child: containerImages[i],
      ),
    ));
  }
}

List<String> buildText(FilterResponse filterResponse, int screenIndex) {
  List<String> keyWords = filterResponse.filterModels[screenIndex].keyWords;
  List<String> badWords = filterResponse.filterModels[screenIndex].badWords;
  String res1 = '', res2 = '';
  for (int i = 0; i < keyWords.length; i++) {
    if (!(i + 1 == keyWords.length)) {
      res1 += keyWords[i] + ", ";
    } else {
      res1 += keyWords[i];
    }
  }
  for (int i = 0; i < badWords.length; i++) {
    if (!(i + 1 == badWords.length)) {
      res2 += badWords[i] + ", ";
    } else {
      res2 += badWords[i];
    }
  }
  List<String> response = [res1, res2];
  return response;
}
