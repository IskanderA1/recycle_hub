import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:recycle_hub/model/map_models.dart/marker.dart';

///Контейнер, который первым показывается по нажатию на маркер, с увеличеним offset уменьшается
class AnimatedPreInformationContainer extends StatefulWidget {
  final CustMarker marker;
  final double offset;

  AnimatedPreInformationContainer(
      {@required this.offset, @required this.marker});
  @override
  _AnimatedPreInformationContainerState createState() =>
      _AnimatedPreInformationContainerState();
}

class _AnimatedPreInformationContainerState
    extends State<AnimatedPreInformationContainer> {
  Widget widgetVisible;
  Widget widgetNotVisable = Container();
  @override
  Widget build(BuildContext context) {
    widgetVisible = newMethod();
    return AnimatedContainer(
        duration: Duration(milliseconds: 200),
        height: widget.offset <= 0.4 ? 302 : 0,
        color: Colors.white,
        onEnd: () {},
        child: Padding(
            padding: EdgeInsets.all(15),
            child: widget.offset == 0.4 ? widgetVisible : widgetNotVisable));
  }

  Column newMethod() {
    return Column(
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
                    Flexible(
                      child: AutoSizeText(
                        widget.marker.name,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.visible,
                      ),
                    ),
                    Flexible(
                      child: AutoSizeText(
                        "Рейтинг",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: AutoSizeText(
                          widget.marker.address,
                          style: TextStyle(fontSize: 16),
                          overflow: TextOverflow.visible,
                        ),
                      ),
                      Container(child: AutoSizeText("800 м")),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText(widget.marker.workTime.getWorkingTime()),
                AutoSizeText("Подробнее")
              ]),
        ),
        Expanded(
          flex: 1,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            AutoSizeText("Принимают на переработку:"),
          ]),
        ),
        Expanded(
            flex: 1,
            child: GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemCount: widget.marker.acceptTypes.length,
              itemBuilder: (context, index) {
                return AutoSizeText(
                  "  ${widget.marker.acceptTypes[index].name}  ",
                  style: TextStyle(backgroundColor: Color(0xFFF2F2F2)),
                );
              },
            ))
      ],
    );
  }
}

List<Widget> getChilds(CustMarker marker) {
  List<AutoSizeText> list = List<AutoSizeText>();

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
