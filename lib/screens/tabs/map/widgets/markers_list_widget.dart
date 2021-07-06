import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_star_rating/flutter_star_rating.dart';
import 'package:recycle_hub/model/map_models.dart/marker.dart';
import 'package:recycle_hub/screens/tabs/map/widgets/working_days_widget.dart';
import 'package:recycle_hub/style/theme.dart';

class MarkersListWidget extends StatefulWidget {
  final List<Widget> list;
  const MarkersListWidget({
    Key key,
    this.list,
  }) : super(key: key);

  @override
  _MarkersListWidgetState createState() => _MarkersListWidgetState();
}

class _MarkersListWidgetState extends State<MarkersListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(color: kColorWhite, child: Column(children: widget.list));
  }
}

class MarkerCardWidget extends StatelessWidget {
  final GridView list;
  final int index;
  final CustMarker marker;
  final String distance;

  const MarkerCardWidget(
      {Key key,
      @required this.index,
      @required this.marker,
      @required this.list,
      @required this.distance})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 30, 16, 30),
      child: Container(
        decoration: BoxDecoration(
            color: marker.paybackType == 'partner' ? kColorGreen : kColorPink,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: AutoSizeText(
                      marker.name,
                      style: TextStyle(
                          color: marker.paybackType == 'partner'
                              ? kColorWhite
                              : kColorBlack,
                          fontFamily: "Gilroy",
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  StarRating(
                      rating: 3.5,
                      spaceBetween: 1,
                      starConfig: StarConfig(
                        fillColor: marker.paybackType == 'partner'
                            ? kColorWhite
                            : kColorBlack,
                        size: 15,
                        emptyColor: marker.paybackType == 'partner'
                            ? kColorGreen
                            : kColorPink,
                        strokeColor: marker.paybackType == 'partner'
                            ? kColorWhite
                            : kColorBlack,
                      ))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 5, 16, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      marker.address,
                      style: TextStyle(
                        color: marker.paybackType == 'partner'
                            ? kColorWhite
                            : kColorBlack,
                        fontFamily: "Gilroy",
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Flexible(
                    child: AutoSizeText(
                      distance,
                      style: TextStyle(
                          color: marker.paybackType == 'partner'
                              ? kColorWhite
                              : kColorBlack,
                          fontFamily: "Gilroy",
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Align(
                alignment: Alignment.center,
                child: WorkingDaysWidget(
                  workingTime: marker.workTime,
                  wColor: marker.paybackType == 'partner'
                      ? kColorWhite
                      : kColorBlack,
                  backColor: marker.paybackType == 'partner'
                      ? kColorGreen
                      : kColorPink,
                  hasSelection: false,
                  fontSize: 13,
                  size: Size(_size.width - 50, 130),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        "Принимают на переработку:",
                        style: TextStyle(
                            color: marker.paybackType == 'partner'
                                ? kColorWhite
                                : kColorBlack,
                            fontFamily: "Gilroy",
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                    ]),
              ),
            ),
            Container(padding: EdgeInsets.fromLTRB(16, 2, 16, 18), child: list)
          ],
        ),
      ),
    );
  }
}
