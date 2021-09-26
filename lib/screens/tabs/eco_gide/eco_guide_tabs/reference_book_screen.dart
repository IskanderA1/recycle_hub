import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:recycle_hub/bloc/eco_guide_blocs/button_switch_bloc.dart';
import 'package:recycle_hub/bloc/eco_guide_blocs/trash_details_bloc.dart';
import 'package:recycle_hub/bloc/eco_guide_cubit/eco_guide_cubit_cubit.dart';
import 'package:recycle_hub/elements/loader.dart';
import 'package:recycle_hub/icons/app_bar_icons_icons.dart';
import 'package:recycle_hub/model/eco_guide_models/filter_response.dart';
import 'package:recycle_hub/model/map_models.dart/accept_types.dart';

import '../../../../style/theme.dart';

List<SvgPicture> containerImages = [
  SvgPicture.asset("svg/1.svg"),
  SvgPicture.asset("svg/2.svg"),
  SvgPicture.asset("svg/3.svg"),
  SvgPicture.asset("svg/4.svg"),
  SvgPicture.asset("svg/5.svg")
];

List<String> containerTitles = ["Бумага", "Пластик", "Стекло", "Мусор", "Отходы"];

List<Tab> tabList = [];

class ReferenceBookScreen extends StatefulWidget {
  @override
  _ReferenceBookScreenState createState() => _ReferenceBookScreenState();
}

class _ReferenceBookScreenState extends State<ReferenceBookScreen> {
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
            "Справочник маркировок",
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              AppBarIcons.back,
              color: kColorWhite,
              size: 18,
            ),
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
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: ContainerListView(filterModels, snapshot.data, screenIndex),
        ),
      );
    },
  );
}

class ContainerListView extends StatelessWidget {
  List<FilterType> filterModels;
  StateButtons stateButtons;
  int screenIndex;
  Widget properties;
  ContainerListView(List<FilterType> filterModels, StateButtons stateButtons, int screenIndex) {
    this.filterModels = filterModels;
    this.stateButtons = stateButtons;
    this.screenIndex = screenIndex;
    this.properties = AllowedItems(filterModels[screenIndex].keyWords);
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
        color: kColorGreyVeryLight,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: kColorGreyLight,
            blurRadius: 3,
            spreadRadius: 1.5,
          ),
        ],
      ),
      padding: EdgeInsets.only(left: 20, top: 10, right: 20),
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      height: MediaQuery.of(context).size.height - 310,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        padding: const EdgeInsets.only(
          bottom: 85,
        ),
        children: _buildAllowedItems(allowedItems),
      ),
    );
  }
}

List<Widget> _buildAllowedItems(List<String> allowedItems) {
  List<Widget> listItems = List<Widget>();
  print(allowedItems[0]);
  for (int i = 0; i < allowedItems.length; i++) {
    listItems.add(Row(
      children: [
        Expanded(
          child: Container(
            height: 125,
            margin: EdgeInsets.only(right: 2),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kBorderRadius)),
              elevation: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(flex: 2, child: containerImages[4]),
                  Expanded(
                    flex: 3,
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      runAlignment: WrapAlignment.center,
                      children: [
                        Text(allowedItems[i]),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
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
