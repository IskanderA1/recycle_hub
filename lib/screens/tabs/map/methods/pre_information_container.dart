import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycle_hub/api/services/points_service.dart';
import 'package:recycle_hub/helpers/distance_helper.dart';
import 'package:recycle_hub/model/map_models.dart/accept_types.dart';
import 'package:recycle_hub/model/map_models.dart/marker.dart';
import 'package:recycle_hub/style/theme.dart';

///Контейнер, который первым показывается по нажатию на маркер, с увеличеним offset уменьшается
class AnimatedPreInformationContainer extends StatefulWidget {
  final CustMarker marker;
  final double offset;
  final List<FilterType> filters;
  final Point userPoint;

  AnimatedPreInformationContainer({@required this.offset, @required this.marker, @required this.filters, @required this.userPoint});
  @override
  _AnimatedPreInformationContainerState createState() => _AnimatedPreInformationContainerState();
}

class _AnimatedPreInformationContainerState extends State<AnimatedPreInformationContainer> {
  Widget widgetVisible;
  Widget widgetNotVisable = Container();
  Size size;
  double distance;

  @override
  void initState() {
    distance = distanceInKm(Point(widget.marker.coords[0], widget.marker.coords[1]), widget.userPoint);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(bottom: 8),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: AutoSizeText(
                        widget.marker.name,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(
                        child: AutoSizeText(
                          widget.marker.address,
                          style: TextStyle(fontSize: 16),
                          overflow: TextOverflow.visible,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                          child:
                              AutoSizeText(distance < 1 ? distance.toStringAsFixed(3).split(',').last + ' м' : distance.toStringAsFixed(1) + ' км')),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 8),
            child: Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.recycle,
                  size: 30,
                  color: Color(0xFF8D8D8D),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(
                    "Принимают на переработку:",
                    style: TextStyle(color: kColorBlack, fontWeight: FontWeight.w400, fontFamily: 'GilroyMedium', fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 8,
              left: 16,
              right: 16,
            ),
            child: FilterTypesContainer(
              filters: widget.filters,
              gridSize: 30,
            ),
          ),
          if (widget.offset == 0.2)
            SizedBox(
              height: 200,
            )
        ],
      ),
    );
    /* return AnimatedContainer(
        duration: Duration(milliseconds: 400),
        //height: 350,
        color: Colors.white,
        onEnd: () {},
        child: widget.offset <= 0.5 ? widgetVisible : widgetNotVisable); */
  }
}

class FilterTypesContainer extends StatelessWidget {
  const FilterTypesContainer({Key key, @required this.filters, @required this.gridSize}) : super(key: key);

  final List<FilterType> filters;
  final double gridSize;

  @override
  Widget build(BuildContext context) {
    if (filters.isEmpty) {
      return Container();
    }
    return SizedBox(
      height: gridSize,
      child: GridView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 250,
          childAspectRatio: 2 / 9,
          crossAxisSpacing: 2,
          mainAxisSpacing: 8,
        ),
        itemCount: filters.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(color: Color(0xFFF2F2F2), borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Center(
              child: AutoSizeText(
                "${filters[index].name}",
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Gilroy', fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          );
        },
      ),
    );
  }
}

List<Widget> getChilds(CustMarker marker) {
  List<AutoSizeText> list = List<AutoSizeText>.empty(growable: true);

  for (int i = 0; i < marker.acceptTypes.length; i++) {
    list.add(AutoSizeText(
      "  marker.acceptTypes[i].name  ",
      style: TextStyle(backgroundColor: Color(0xFFF2F2F2)),
    ));
  }
  return list;
}
/*
AnimatedContainer preInformationContainer(double offset, CustMarker marker) {
  GridView _view = GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
    itemCount: marker.acceptTypes.length,
    itemBuilder: (context, index) {
      return AutoSizeText(
        "  ${marker.acceptTypes[index].name}  ",
        style: TextStyle(backgroundColor: Color(0xFFF2F2F2)),
      );
    },
  );

  GridView _normView = GridView.count(
    crossAxisCount: 3,
    children: getChilds(marker),
  );

  GridView _view0 = GridView.count(
    crossAxisCount: 3,
    children: [],
  );
  ;

  return AnimatedContainer(
      duration: Duration(milliseconds: 700),
      height: offset <= 0.4 ? 302 : 0,
      color: Colors.white,
      onEnd: () {
        _view0 = _normView;
      },
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          marker.name,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Рейтинг",
                          style: TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AutoSizeText(
                          marker.address,
                          style: TextStyle(fontSize: 16),
                        ),
                        AutoSizeText("800 м"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: offset <= 0.4
                    ? [
                        AutoSizeText(marker.workTime.getWorkingTime()),
                        AutoSizeText("Подробнее")
                      ]
                    : [],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: offset <= 0.4
                    ? [
                        AutoSizeText("Принимают на переработку:"),
                      ]
                    : [],
              ),
            ),
            Expanded(flex: 1, child: _view0)
          ],
        ),
      ));
}
*/
