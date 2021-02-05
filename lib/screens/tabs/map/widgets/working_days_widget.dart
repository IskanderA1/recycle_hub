import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:recycle_hub/model/map_models.dart/work_time.dart';
import 'package:recycle_hub/style/theme.dart';

class WorkingDaysWidget extends StatefulWidget {
  final WorkingTime workingTime;
  const WorkingDaysWidget({Key key, this.workingTime}) : super(key: key);

  @override
  _WorkingDaysWidgetState createState() => _WorkingDaysWidgetState();
}

class _WorkingDaysWidgetState extends State<WorkingDaysWidget> {
  double _size;

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    String dateFormat = DateFormat('EEEE').format(date);
    print(dateFormat);
    Size _fullSize = MediaQuery.of(context).size;
    _size = (_fullSize.width - 62) / 7;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FaIcon(
              FontAwesomeIcons.clock,
              color: Color(0xFF8D8D8D),
              size: 30,
            ),
            SizedBox(
              width: 15,
            ),
            AutoSizeText(
              "Сегодня ${widget.workingTime.getByInd(dateFormat)}",
              style: TextStyle(
                  color: kColorBlack, fontFamily: 'GilroyMedium', fontSize: 16),
            )
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          height: _fullSize.height / 6.1,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              DayWidget(
                dayName: "ПН",
                dayArr: widget.workingTime.mon,
                isSelected: dateFormat == "Monday" ? true : false,
                sWidth: _size,
              ),
              VerticalDivider(
                color: Color(0xF2707070),
                indent: 3,
                endIndent: 3,
                width: 2,
                thickness: 0.6,
              ),
              DayWidget(
                dayName: "ВТ",
                dayArr: widget.workingTime.mon,
                isSelected: dateFormat == "Tuesday" ? true : false,
                sWidth: _size,
              ),
              VerticalDivider(
                color: Color(0xF2707070),
                indent: 3,
                endIndent: 3,
                width: 2,
                thickness: 0.6,
              ),
              DayWidget(
                dayName: "СР",
                dayArr: widget.workingTime.mon,
                isSelected: dateFormat == "Wednesday" ? true : false,
                sWidth: _size,
              ),
              VerticalDivider(
                color: Color(0xF2707070),
                indent: 3,
                endIndent: 3,
                width: 2,
                thickness: 0.6,
              ),
              DayWidget(
                dayName: "ЧТ",
                dayArr: widget.workingTime.mon,
                isSelected: dateFormat == "Thursday" ? true : false,
                sWidth: _size,
              ),
              VerticalDivider(
                color: Color(0xF2707070),
                indent: 3,
                endIndent: 3,
                width: 2,
                thickness: 0.6,
              ),
              DayWidget(
                dayName: "ПТ",
                dayArr: widget.workingTime.mon,
                isSelected: dateFormat == "Friday" ? true : false,
                sWidth: _size,
              ),
              VerticalDivider(
                color: Color(0xF2707070),
                indent: 3,
                endIndent: 3,
                width: 2,
                thickness: 0.6,
              ),
              DayWidget(
                dayName: "СБ",
                dayArr: widget.workingTime.mon,
                isSelected: dateFormat == "Saturday" ? true : false,
                sWidth: _size,
              ),
              VerticalDivider(
                color: Color(0xF2707070),
                indent: 3,
                endIndent: 3,
                width: 2,
                thickness: 0.6,
              ),
              DayWidget(
                dayName: "ВС",
                dayArr: widget.workingTime.mon,
                isSelected: dateFormat == "Sunday" ? true : false,
                sWidth: _size,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class DayWidget extends StatefulWidget {
  DayWidget(
      {Key key,
      @required this.dayName,
      @required this.dayArr,
      this.isSelected,
      this.sWidth})
      : super(key: key);

  final String dayName;
  final List<String> dayArr;
  final bool isSelected;
  final sWidth;

  @override
  _DayWidgetState createState() => _DayWidgetState();
}

class _DayWidgetState extends State<DayWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.sWidth,
      color: widget.isSelected ? kColorRed.withOpacity(0.65) : kColorWhite,
      child: (Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 3.25),
            child: Flexible(
              child: AutoSizeText(
                "${widget.dayName}\n",
                style: TextStyle(
                    fontFamily: 'GilroyMedium',
                    color: widget.isSelected ? kColorBlack : kColorGreyLight),
              ),
            ),
          ),
          Flexible(
            child: AutoSizeText(
              "${widget.dayArr[0]}\n${widget.dayArr[3]}",
              style: TextStyle(
                  fontFamily: 'GilroyMedium',
                  color: widget.isSelected ? kColorBlack : kColorGreyLight),
            ),
          ),
          Flexible(
            child: AutoSizeText(
              "·",
              style: TextStyle(
                  fontSize: 35,
                  color: widget.isSelected ? kColorBlack : kColorGreyLight,
                  fontWeight: FontWeight.w900),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 3.25),
              child: AutoSizeText(
                "${widget.dayArr[1]}\n${widget.dayArr[2]}",
                style: TextStyle(
                    fontFamily: 'GilroyMedium',
                    color: widget.isSelected ? kColorBlack : kColorGreyLight),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
