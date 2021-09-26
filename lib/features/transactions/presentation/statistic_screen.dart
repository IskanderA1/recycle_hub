import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:http/retry.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:recycle_hub/bloc/cubit/profile_menu_cubit.dart';
import 'package:recycle_hub/features/transactions/domain/model/statistic_model.dart';
import 'package:recycle_hub/features/transactions/domain/state/transactions_state.dart';
import 'package:recycle_hub/features/transactions/presentation/components/drop_down_menu_button.dart';
import 'package:recycle_hub/helpers/messager_helper.dart';
import 'package:recycle_hub/icons/app_bar_icons_icons.dart';
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
    _disposer = reaction((_) => _transactionsState.errorMessage, (String message) => showMessage(context: context, message: message));
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
        GetIt.I.get<ProfileMenuCubit>().goBack();
        return;
      },
      child: Scaffold(
        backgroundColor: kColorWhite,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Статистика",
            /* style: TextStyle(fontFamily: 'Gillroy'), */
          ),
          leading: GestureDetector(
            onTap: () {
              GetIt.I.get<ProfileMenuCubit>().goBack();
            },
            child: Icon(
              AppBarIcons.back,
              size: 18,
            ),
          ),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: kColorScaffold,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Container(
              decoration: BoxDecoration(
                  color: kColorWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(kBorderRadius),
                    topRight: Radius.circular(kBorderRadius),
                  )),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _currentPeriod.from.year == _currentPeriod.to.year
                                    ? "${_currentPeriod.to.year}"
                                    : "${_currentPeriod.from.year} - ${_currentPeriod.to.year}",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, fontFamily: 'Gillroy'),
                              ),
                              Text(
                                "${_currentPeriod.monthFrom} ${_currentPeriod.from.day} - ${_currentPeriod.monthTo} ${_currentPeriod.to.day}",
                                style: TextStyle(fontSize: 14, fontFamily: 'Gillroy'),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(kBorderRadius),
                            ),
                            child: MenuButton<DropDownMenuItem>(
                              decoration: BoxDecoration(
                                color: Color(0xFFF7F7F7),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(kBorderRadius),
                                ),
                              ),
                              selectedItem: _currentPeriod,
                              itemBackgroundColor: Color(0xFFF7F7F7),
                              menuButtonBackgroundColor: Color(0xFFF7F7F7),
                              child: DropDownMenuChildButton(
                                selectedItem: "${_currentPeriod.count} ${_currentPeriod.name}",
                              ),
                              items: _datesList,
                              itemBuilder: (DropDownMenuItem item) => Container(
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF7F7F7),
                                ),
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                                child: Text("${item.count} ${item.name}"),
                              ),
                              toggledChild: Container(
                                child: DropDownMenuChildButton(
                                  selectedItem: "${_currentPeriod.count} ${_currentPeriod.name}",
                                ),
                              ),
                              onItemSelected: (DropDownMenuItem item) {
                                _transactionsState.getTransacts(item.from, item.to);
                                setState(() {
                                  _currentPeriod = item;
                                });
                              },
                              onMenuButtonToggle: (bool isTohgle) {
                                print(isTohgle);
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Observer(builder: (_) {
                      if (_transactionsState.state == StoreState.INIT) {
                        return Container();
                      } else if (_transactionsState.state == StoreState.LOADING) {
                        return LoaderWidget();
                      } else if (_transactionsState.state == StoreState.LOADED) {
                        final _count = (_transactionsState.totalKG ?? 0).round().toString();
                        var msg = 'Вы сдали более';
                        if (_count == '0') {
                          msg = 'Здесь пока пусто';
                        } else {
                          msg = msg + ' $_count';
                        }
                        return Column(
                          children: [
                            Text(
                              msg,
                              style: TextStyle(fontSize: 16, fontFamily: 'GillroyMedium'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            StatisticWidget(
                              statisticModel: _transactionsState.statisticModel,
                              totalKG: _transactionsState.totalKG,
                            ),
                          ],
                        );
                      }
                      return Container();
                    }),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            child: Stack(
                              fit: StackFit.passthrough,
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
                                          Radius.circular(kBorderRadius),
                                        ),
                                      ),
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
                                          Radius.circular(kBorderRadius),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.arrow_upward,
                                        color: kColorGreen,
                                        size: 25,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Container(
                                      width: 70,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Observer(builder: (_) {
                                            if (_transactionsState.state == StoreState.INIT) {
                                              return FittedBox(
                                                child: Text(
                                                  "Пока пусто",
                                                  style: TextStyle(
                                                    color: kColorGreyLight,
                                                    fontSize: 12,
                                                    fontFamily: 'Gillroy',
                                                  ),
                                                ),
                                              );
                                            } else if (_transactionsState.state == StoreState.LOADING) {
                                              return SpinKitWave(
                                                color: kColorGreen,
                                                size: 20,
                                              );
                                            } else if (_transactionsState.state == StoreState.LOADED) {
                                              return Text(
                                                "Вы сдали всего ${_transactionsState.totalKG} кг",
                                                style: TextStyle(
                                                  color: kColorGreyLight,
                                                  fontSize: 12,
                                                  fontFamily: 'Gillroy',
                                                ),
                                              );
                                            }
                                            return Container();
                                          }),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 1,
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            fit: StackFit.passthrough,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 55,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF7F7F7),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(kBorderRadius),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF3DE77),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(kBorderRadius),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.copyright,
                                      color: const Color(0xFFC8BB42),
                                      size: 25,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Observer(builder: (_) {
                                          if (_transactionsState.state == StoreState.INIT) {
                                            return RichText(
                                              overflow: TextOverflow.visible,
                                              maxLines: 3,
                                              text: TextSpan(
                                                text: 'Пока пусто',
                                                style: TextStyle(
                                                  color: kColorGreyLight,
                                                  fontSize: 12,
                                                  fontFamily: 'Gillroy',
                                                ),
                                              ),
                                            );
                                          } else if (_transactionsState.state == StoreState.LOADING) {
                                            return SpinKitWave(
                                              color: kColorGreen,
                                              size: 20,
                                            );
                                          } else if (_transactionsState.state == StoreState.LOADED) {
                                            return RichText(
                                              text: TextSpan(
                                                text: 'Вы заработали ',
                                                style: TextStyle(
                                                  color: kColorGreyLight,
                                                  fontSize: 12,
                                                  fontFamily: 'Gillroy',
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: _transactionsState.summ.toString(),
                                                    style: TextStyle(
                                                      color: kColorGreyLight,
                                                      fontSize: 12,
                                                      fontFamily: 'Gillroy',
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: ' ЭкоКоинов',
                                                    style: TextStyle(
                                                      color: kColorGreyLight,
                                                      fontSize: 12,
                                                      fontFamily: 'Gillroy',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                          return Container();
                                        }),
                                      ],
                                    ),
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
  const StatisticWidget({Key key, @required this.statisticModel, this.totalKG}) : super(key: key);
  final List<StatisticModel> statisticModel;
  final double totalKG;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: statisticModel.length,
      itemBuilder: (context, index) {
        if (statisticModel[index] == null) {
          return Container();
        }
        return StatisticListElement(
          svgId: 0,
          name: "${statisticModel[index].filterType.name}",
          kg: "${statisticModel[index].count}",
          percent: "${(statisticModel[index].count * 100 / totalKG).roundToDouble()}",
        );
      },
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            decoration: BoxDecoration(color: Color(0xFFF2F2F2), borderRadius: BorderRadius.all(Radius.circular(kBorderRadius))),
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
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'Gillroy'),
                      ),
                      Column(
                        children: [
                          Text(
                            "$kgкг",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'Gillroy'),
                          ),
                          Text(
                            "$percent% от общего",
                            style: TextStyle(fontSize: 10, color: kColorBlack.withOpacity(0.6), fontFamily: 'Gillroy'),
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
  DropDownMenuItem({@required this.name, @required this.count, @required this.duration}) {
    to = DateTime.now();
    from = to.subtract(duration);
    monthFrom = DateFormat.MMMM().format(from);
    monthTo = DateFormat.MMMM().format(to);
  }
}
