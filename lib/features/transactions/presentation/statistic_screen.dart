import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:recycle_hub/bloc/profile_bloc/profile_bloc.dart';
import 'package:recycle_hub/features/transactions/domain/model/statistic_model.dart';
import 'package:recycle_hub/features/transactions/domain/state/transactions_state.dart';
import 'package:recycle_hub/screens/tabs/map/widgets/loader_widget.dart';
import 'package:recycle_hub/style/theme.dart';
import 'package:menu_button/menu_button.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:mobx/mobx.dart';

List<Widget> sIcons = [
  SvgPicture.asset("svg/blue_container.svg"),
  SvgPicture.asset("svg/yellow_container.svg"),
  SvgPicture.asset("svg/green_container.svg"),
  SvgPicture.asset("svg/red_container.svg"),
  SvgPicture.asset("svg/black_container.svg"),
  Icon(Icons.more_horiz, color: kColorBlack)
];

class StatisticScreen extends StatefulWidget {
  @override
  _StatisticScreenState createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  List<DropDownMenuItem> _datesList = [
    DropDownMenuItem(count: 1, name: "Неделя", duration: Duration(days: 7)),
    DropDownMenuItem(count: 1, name: "Месяц", duration: Duration(days: 30)),
    DropDownMenuItem(count: 3, name: "Месяца", duration: Duration(days: 92)),
    DropDownMenuItem(count: 1, name: "Год", duration: Duration(days: 365))
  ];
  DropDownMenuItem _currentPeriod;
  TransactionsState _transactionsState;
  ReactionDisposer _disposer;

  @override
  void initState() {
    super.initState();
    _currentPeriod = _datesList[0];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _transactionsState ??= Provider.of<TransactionsState>(context);
    _disposer = reaction(
        (_) => _transactionsState.errorMessage,
        (String message) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message), duration: Duration(seconds: 5))));
  }

  @override
  void dispose() {
    super.dispose();
    _disposer();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        profileMenuBloc.mapEventToState(ProfileMenuStates.MENU);
        return;
      },
      child: Scaffold(
        backgroundColor: kColorWhite,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Статистика",
            style: TextStyle(fontFamily: 'Gillroy'),
          ),
          leading: GestureDetector(
            onTap: () {
              profileMenuBloc.mapEventToState(ProfileMenuStates.MENU);
            },
            child: Icon(
              Icons.arrow_back,
              color: kColorWhite,
              size: 35,
            ),
          ),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Color(0xFFF2F2F2),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
            child: Container(
              decoration: BoxDecoration(
                  color: kColorWhite,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _currentPeriod.from.year == _currentPeriod.to.year
                                  ? "${_currentPeriod.to.year}"
                                  : "${_currentPeriod.from.year} - ${_currentPeriod.to.year}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  fontFamily: 'Gillroy'),
                            ),
                            Text(
                                "${_currentPeriod.monthFrom} ${_currentPeriod.from.day} - ${_currentPeriod.monthTo} ${_currentPeriod.to.day}",
                                style: TextStyle(
                                    fontSize: 14, fontFamily: 'Gillroy')),
                          ],
                        ),
                        /*ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          child: MenuButton<DropDownMenuItem>(
                            decoration: BoxDecoration(
                                color: Color(0xFFF7F7F7),
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            selectedItem: _currentPeriod,
                            itemBackgroundColor: Color(0xFFF7F7F7),
                            menuButtonBackgroundColor: Color(0xFFF7F7F7),
                            child: NormalChildButton(
                              selectedItem: _currentPeriod,
                            ),
                            items: _datesList,
                            itemBuilder: (DropDownMenuItem item) => Container(
                              height: 30,
                              decoration: BoxDecoration(
                                color: Color(0xFFF7F7F7),
                              ),
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 20),
                              child: Text("${item.count} ${item.name}"),
                            ),
                            toggledChild: Container(
                              child: NormalChildButton(
                                selectedItem: _currentPeriod,
                              ),
                            ),
                            onItemSelected: (DropDownMenuItem item) {
                              _transactionsState.getTransacts(
                                  Hive.box('user').get('user').id);
                              setState(() {
                                _currentPeriod = item;
                              });
                            },
                            onMenuButtonToggle: (bool isTohgle) {
                              print(isTohgle);
                            },
                          ),
                        )*/
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Сколько сдал по отдельности",
                      style:
                          TextStyle(fontSize: 16, fontFamily: 'GillroyMedium'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Observer(builder: (_) {
                      if (_transactionsState.state == StoreState.INIT) {
                        return Container();
                      }
                      if (_transactionsState.state == StoreState.LOADING) {
                        return LoaderWidget();
                      }
                      if (_transactionsState.state == StoreState.LOADED) {
                        return StatisticWidget(
                            statisticModel: _transactionsState.statisticModel);
                      }
                    }),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    height: 55,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFF7F7F7),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFDCF4E0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Icon(
                                      Icons.arrow_upward,
                                      color: kColorGreen,
                                      size: 25,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Сдал всего",
                                          style: TextStyle(
                                            color: kColorGreyLight,
                                            fontSize: 12,
                                            fontFamily: 'Gillroy',
                                          )),
                                      Observer(builder: (_) {
                                        if (_transactionsState.state ==
                                            StoreState.INIT) {
                                          return Container();
                                        }
                                        if (_transactionsState.state ==
                                            StoreState.LOADING) {
                                          return SpinKitWave(
                                            color: kColorGreen,
                                            size: 20,
                                          );
                                        }
                                        if (_transactionsState.state ==
                                            StoreState.LOADED) {
                                          return Text(
                                              "${_transactionsState.statisticModel.totalKG}кг",
                                              style: TextStyle(
                                                  color:
                                                      const Color(0xFF484848),
                                                  fontSize: 13,
                                                  fontFamily: 'Gillroy',
                                                  fontWeight: FontWeight.bold));
                                        }
                                      }),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    height: 55,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFF7F7F7),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFF3DE77),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Icon(
                                      Icons.attach_money,
                                      color: const Color(0xFFC8BB42),
                                      size: 25,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Заработал",
                                          style: TextStyle(
                                            color: kColorGreyLight,
                                            fontSize: 12,
                                            fontFamily: 'Gillroy',
                                          )),
                                      Observer(builder: (_) {
                                        if (_transactionsState.state ==
                                            StoreState.INIT) {
                                          return Container();
                                        }
                                        if (_transactionsState.state ==
                                            StoreState.LOADING) {
                                          return SpinKitWave(
                                            color: kColorGreen,
                                            size: 20,
                                          );
                                        }
                                        if (_transactionsState.state ==
                                            StoreState.LOADED) {
                                          return Text(
                                              r'$' +
                                                  " ${_transactionsState.statisticModel.summ}",
                                              style: TextStyle(
                                                  color:
                                                      const Color(0xFF484848),
                                                  fontSize: 13,
                                                  fontFamily: 'Gillroy',
                                                  fontWeight: FontWeight.bold));
                                        }
                                      }),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Spacer()
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

class StatisticWidget extends StatelessWidget {
  const StatisticWidget({Key key, @required this.statisticModel})
      : super(key: key);
  final StatisticModel statisticModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: StatisticListElement(
            svgId: 0,
            name: "Бумага",
            kg: "${statisticModel.paperKG}",
            percent: "${(statisticModel.paperKG * 100 / statisticModel.totalKG).roundToDouble()}",
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: StatisticListElement(
            svgId: 1,
            name: "Пластик",
            kg: "${statisticModel.plasticKG}",
            percent:
                "${(statisticModel.plasticKG * 100 / statisticModel.totalKG).roundToDouble()}",
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: StatisticListElement(
            svgId: 2,
            name: "Стекло",
            kg: "${statisticModel.glassKG}",
            percent: "${(statisticModel.glassKG * 100 / statisticModel.totalKG).roundToDouble()}",
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: StatisticListElement(
            svgId: 3,
            name: "Отходы",
            kg: "${statisticModel.othodyKG}",
            percent:
                "${(statisticModel.othodyKG * 100 / statisticModel.totalKG).roundToDouble()}",
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: StatisticListElement(
            svgId: 4,
            name: "Мусор",
            kg: "${statisticModel.garbageKG}",
            percent:
                "${(statisticModel.garbageKG * 100 / statisticModel.totalKG).roundToDouble()}",
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: StatisticListElement(
            svgId: 5,
            name: "Прочие отходы",
            kg: "${statisticModel.othersKG}",
            percent:
                "${(statisticModel.othersKG * 100 / statisticModel.totalKG).roundToDouble()}",
          ),
        ),
      ],
    );
  }
}

class StatisticListElement extends StatelessWidget {
  const StatisticListElement({
    Key key,
    @required this.svgId,
    @required this.name,
    @required this.kg,
    @required this.percent,
  }) : super(key: key);
  final int svgId;
  final String name;
  final String kg;
  final String percent;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Color(0xFFF2F2F2),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: sIcons[svgId],
          ),
          height: 40,
          width: 40,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            //width: ScreenUtil().screenWidth - 120,
            //padding: EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Gillroy'),
                    ),
                    Column(
                      children: [
                        Text(
                          "$kgкг",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Gillroy'),
                        ),
                        Text(
                          "$percent% от общего",
                          style: TextStyle(
                              fontSize: 10,
                              color: kColorBlack.withOpacity(0.6),
                              fontFamily: 'Gillroy'),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                StepProgressIndicator(
                  totalSteps: 100,
                  direction: Axis.horizontal,
                  currentStep: int.parse(percent.split('.')[0]),
                  size: 10,
                  selectedSize: 8,
                  unselectedSize: 8,
                  padding: 0,
                  selectedColor: kColorGreen,
                  unselectedColor: Color(0xFFF7F7F7),
                  roundedEdges: Radius.circular(5),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class NormalChildButton extends StatelessWidget {
  const NormalChildButton({
    Key key,
    @required DropDownMenuItem selectedItem,
  })  : _selectedItem = selectedItem,
        super(key: key);

  final DropDownMenuItem _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFFF7F7F7), borderRadius: BorderRadius.circular(20)),
      width: 120,
      height: 30,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
                child: Text(
              "${_selectedItem.count} ${_selectedItem.name}",
              overflow: TextOverflow.visible,
            )),
            const SizedBox(
              width: 15,
              height: 20,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Icon(
                  Icons.arrow_drop_down,
                  color: kColorGreyLight,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DropDownMenuItem {
  String name;
  int count;
  Duration duration;
  DateTime to;
  DateTime from;
  String monthFrom;
  String monthTo;
  DropDownMenuItem(
      {@required this.name, @required this.count, @required this.duration}) {
    to = DateTime.now();
    from = to.subtract(duration);
    monthFrom = DateFormat.MMMM().format(from);
    monthTo = DateFormat.MMMM().format(to);
  }
}
