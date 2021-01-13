import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recycle_hub/bloc/eco_guide_blocs/button_switch_bloc.dart';
import 'package:recycle_hub/bloc/eco_guide_blocs/eco_menu_bloc.dart';
import 'package:recycle_hub/bloc/eco_guide_blocs/trash_details_bloc.dart';
import 'package:recycle_hub/elements/loader.dart';
import 'package:recycle_hub/model/eco_guide_models/container_model.dart';
import 'package:recycle_hub/model/eco_guide_models/container_response.dart';

import '../../../../style/theme.dart';

List<SvgPicture> containerImages = [
  SvgPicture.asset("svg/1.svg"),
  SvgPicture.asset("svg/2.svg"),
  SvgPicture.asset("svg/3.svg"),
  SvgPicture.asset("svg/4.svg"),
  SvgPicture.asset("svg/5.svg")
];

List<String> containerTitles = [
  "Бумага",
  "Пластик",
  "Стекло",
  "Мусор",
  "Отходы"
];

List<Tab> tabList = [];

class ReferenceBookScreen extends StatefulWidget {
  @override
  _ReferenceBookScreenState createState() => _ReferenceBookScreenState();
}

class _ReferenceBookScreenState extends State<ReferenceBookScreen> {
  @override
  void initState() {
    trashDetailsBloc.getContainers();
    tabList = [];
    _buildTabList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Справочник маркировок",
            style: TextStyle(),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_sharp),
            onPressed: () {
              ecoMenu.backToMenu();
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
        builder: (context, AsyncSnapshot<ContainerResponse> snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data.containers[0].name);
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

Widget _buildContainerList(
    ContainerResponse containerResponse, int screenIndex) {
  List<ContainerModel> containerModels = containerResponse.containers;
  print(containerModels[0].name);
  return StreamBuilder(
      stream: switchButtonBloc.switchButtonController.stream,
      initialData: switchButtonBloc.defaultStateButton,
      builder: (context, AsyncSnapshot<StateButtons> snapshot) {
        return Container(
          padding: EdgeInsets.only(left: 20, top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildContainerListView(
                  containerModels, snapshot.data, screenIndex)
            ],
          ),
        );
      });
}

class _buildContainerListView extends StatelessWidget {
  List<ContainerModel> containerModels;
  StateButtons stateButtons;
  int screenIndex;
  Widget properties;
  _buildContainerListView(List<ContainerModel> containerModels,
      StateButtons stateButtons, int screenIndex) {
    this.containerModels = containerModels;
    this.stateButtons = stateButtons;
    this.screenIndex = screenIndex;
    this.properties = AllowedItems(containerModels[screenIndex].allowed);
    print(containerModels[screenIndex].allowed[0].name);
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 8.0, left: 8.0),
              child: Text(
                containerTitles[screenIndex],
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                    color: kColorGreyDark),
              ),
            ),
            properties
          ],
        ),
        Container(
          margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width - 170, top: 30),
          width: 180,
          height: 180,
          child: containerImages[screenIndex],
        ),
      ],
    );
  }
}

class AllowedItems extends StatelessWidget {
  List<Allowed> allowedItems;
  AllowedItems(List<Allowed> allowedItems) {
    this.allowedItems = allowedItems;
    print(allowedItems[0].name);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50)),
      ),
      padding: EdgeInsets.only(left: 30, top: 30, right: 80),
      margin: EdgeInsets.only(left: 20, right: 40, top: 20),
      height: MediaQuery.of(context).size.height - 321,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: _buildAllowedItems(allowedItems),
      ),
    );
  }
}

List<Widget> _buildAllowedItems(List<Allowed> allowedItems) {
  List<Widget> listItems = List<Widget>();
  print(allowedItems[0].name +
      allowedItems[0].subjects[0].name +
      allowedItems.length.toString());
  for (int i = 0; i < allowedItems.length; i++) {
    listItems.add(Text(
      allowedItems[i].name,
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 18, color: kColorGreyDark),
    ));
    for (int j = 0; j < allowedItems[i].subjects.length; j++) {
      listItems.add(_buildItem(allowedItems[i].subjects[j].name, null));
    }
  }
  return listItems;
}


Widget _buildItem(String title, Image image) {
  return ListTile(
    leading: image,
    title: Text(
      title,
      style: TextStyle(
          fontSize: 12, fontWeight: FontWeight.bold, color: kColorGreyDark),
    ),
  );
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
