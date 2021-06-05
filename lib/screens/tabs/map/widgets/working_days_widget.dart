import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'package:recycle_hub/model/map_models.dart/work_day.dart';
import 'package:recycle_hub/model/map_models.dart/work_time.dart';
import 'package:recycle_hub/style/theme.dart';

class WorkingDaysWidget extends StatefulWidget {
  final Color wColor;
  final Color backColor;
  final WorkingTime workingTime;
  final bool hasSelection;
  final Size size;
  final double fontSize;
  const WorkingDaysWidget(
      {Key key,
      @required this.workingTime,
      @required this.wColor,
      @required this.backColor,
      @required this.hasSelection,
      @required this.size,
      @required this.fontSize})
      : super(key: key);

  @override
  _WorkingDaysWidgetState createState() => _WorkingDaysWidgetState();
}

class _WorkingDaysWidgetState extends State<WorkingDaysWidget> {
  Widget divider() {
    return VerticalDivider(
      color: widget.wColor,
      indent: 3,
      endIndent: 3,
      width: 2,
      thickness: 0.6,
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    String dateFormat = DateFormat('EEEE').format(date);
    print(dateFormat);
    Size _fullSize = widget.size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FaIcon(
              FontAwesomeIcons.clock,
              color: widget.hasSelection ? kColorGreyDark : widget.wColor,
              size: widget.fontSize + 15,
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              "Сегодня ${widget.workingTime.getByInd(dateFormat)}",
              style: TextStyle(
                  color: widget.wColor,
                  fontFamily: 'GilroyMedium',
                  fontSize: widget.fontSize + 2),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: _fullSize.height,
          width: _fullSize.width,
          color: widget.backColor,
          child: widget.hasSelection
              ? Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    DayWidget(
                      dayName: "ПН",
                      dayArr: widget.workingTime.mon,
                      isSelected: dateFormat == "Monday" ? true : false,
                      textSelectedColor: kColorBlack,
                      textUnSelectedColor: kColorGreyDark,
                      backColor: widget.backColor,
                      fontSize: widget.fontSize,
                    ),
                    divider(),
                    DayWidget(
                      dayName: "ВТ",
                      dayArr: widget.workingTime.mon,
                      isSelected: dateFormat == "Tuesday" ? true : false,
                      textSelectedColor: kColorBlack,
                      textUnSelectedColor: kColorGreyDark,
                      backColor: widget.backColor,
                      fontSize: widget.fontSize,
                    ),
                    divider(),
                    DayWidget(
                      dayName: "СР",
                      dayArr: widget.workingTime.mon,
                      isSelected: dateFormat == "Wednesday" ? true : false,
                      textSelectedColor: kColorBlack,
                      textUnSelectedColor: kColorGreyDark,
                      backColor: widget.backColor,
                      fontSize: widget.fontSize,
                    ),
                    divider(),
                    DayWidget(
                      dayName: "ЧТ",
                      dayArr: widget.workingTime.mon,
                      isSelected: dateFormat == "Thursday" ? true : false,
                      textSelectedColor: kColorBlack,
                      textUnSelectedColor: kColorGreyDark,
                      backColor: widget.backColor,
                      fontSize: widget.fontSize,
                    ),
                    divider(),
                    DayWidget(
                      dayName: "ПТ",
                      dayArr: widget.workingTime.mon,
                      isSelected: dateFormat == "Friday" ? true : false,
                      textSelectedColor: kColorBlack,
                      textUnSelectedColor: kColorGreyDark,
                      backColor: widget.backColor,
                      fontSize: widget.fontSize,
                    ),
                    divider(),
                    DayWidget(
                      dayName: "СБ",
                      dayArr: widget.workingTime.mon,
                      isSelected: dateFormat == "Saturday" ? true : false,
                      textSelectedColor: kColorBlack,
                      textUnSelectedColor: kColorGreyDark,
                      backColor: widget.backColor,
                      fontSize: widget.fontSize,
                    ),
                    divider(),
                    DayWidget(
                      dayName: "ВС",
                      dayArr: widget.workingTime.mon,
                      isSelected: dateFormat == "Sunday" ? true : false,
                      textSelectedColor: kColorBlack,
                      textUnSelectedColor: kColorGreyDark,
                      backColor: widget.backColor,
                      fontSize: widget.fontSize,
                    ),
                  ],
                )
              : Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    DayWidget(
                      dayName: "ПН",
                      dayArr: widget.workingTime.mon,
                      isSelected: false,
                      textSelectedColor: kColorBlack,
                      textUnSelectedColor: widget.wColor,
                      backColor: widget.backColor,
                      fontSize: widget.fontSize,
                    ),
                    divider(),
                    DayWidget(
                      dayName: "ВТ",
                      dayArr: widget.workingTime.mon,
                      isSelected: false,
                      textSelectedColor: kColorBlack,
                      textUnSelectedColor: widget.wColor,
                      backColor: widget.backColor,
                      fontSize: widget.fontSize,
                    ),
                    divider(),
                    DayWidget(
                      dayName: "СР",
                      dayArr: widget.workingTime.mon,
                      isSelected: false,
                      textSelectedColor: kColorBlack,
                      textUnSelectedColor: widget.wColor,
                      backColor: widget.backColor,
                      fontSize: widget.fontSize,
                    ),
                    divider(),
                    DayWidget(
                      dayName: "ЧТ",
                      dayArr: widget.workingTime.mon,
                      isSelected: false,
                      textSelectedColor: kColorBlack,
                      textUnSelectedColor: widget.wColor,
                      backColor: widget.backColor,
                      fontSize: widget.fontSize,
                    ),
                    divider(),
                    DayWidget(
                      dayName: "ПТ",
                      dayArr: widget.workingTime.mon,
                      isSelected: false,
                      textSelectedColor: kColorBlack,
                      textUnSelectedColor: widget.wColor,
                      backColor: widget.backColor,
                      fontSize: widget.fontSize,
                    ),
                    divider(),
                    DayWidget(
                      dayName: "СБ",
                      dayArr: widget.workingTime.mon,
                      isSelected: false,
                      textSelectedColor: kColorBlack,
                      textUnSelectedColor: widget.wColor,
                      backColor: widget.backColor,
                      fontSize: widget.fontSize,
                    ),
                    divider(),
                    DayWidget(
                      dayName: "ВС",
                      dayArr: widget.workingTime.mon,
                      isSelected: false,
                      textSelectedColor: kColorBlack,
                      textUnSelectedColor: widget.wColor,
                      backColor: widget.backColor,
                      fontSize: widget.fontSize,
                    ),
                  ],
                ),
        )
      ],
    );
  }
}

class DayWidget extends StatelessWidget {
  DayWidget(
      {Key key,
      @required this.dayName,
      @required this.dayArr,
      @required this.isSelected,
      @required this.textSelectedColor,
      @required this.textUnSelectedColor,
      @required this.backColor,
      @required this.fontSize})
      : super(key: key);

  final String dayName;
  final WorkDay dayArr;
  final bool isSelected;
  final Color textSelectedColor;
  final Color textUnSelectedColor;
  final Color backColor;
  final double fontSize;
  static const String str = "--.--";

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: isSelected ? kColorRed.withOpacity(0.65) : backColor,
        child: (Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "$dayName\n",
              style: TextStyle(
                  fontFamily: 'GilroyMedium',
                  fontSize: fontSize + 2,
                  color: isSelected ? textSelectedColor : textUnSelectedColor),
            ),
            Text(
              dayArr != null ? "${dayArr.first}\n${dayArr.fourth}" : str,
              style: TextStyle(
                  fontFamily: 'GilroyMedium',
                  fontSize: fontSize,
                  color: isSelected ? textSelectedColor : textUnSelectedColor),
            ),
            Text(
              "·",
              style: TextStyle(
                  fontSize: fontSize + 10,
                  color: isSelected ? textSelectedColor : textUnSelectedColor,
                  fontWeight: FontWeight.w900),
            ),
            Text(
              dayArr != null ? "${dayArr.second}\n${dayArr.third}" : str,
              style: TextStyle(
                  fontFamily: 'GilroyMedium',
                  fontSize: fontSize,
                  color: isSelected ? textSelectedColor : textUnSelectedColor),
            ),
          ],
        )),
      ),
    );
  }
}

class DaysRow extends StatelessWidget {
  final WorkingTime workingTime;
  final double sSize;
  final double fontSize;

  Widget divider() {
    return VerticalDivider(
      color: kColorBlack,
      indent: 3,
      endIndent: 3,
      width: 2,
      thickness: 0.6,
    );
  }

  const DaysRow(
      {Key key,
      @required this.workingTime,
      @required this.sSize,
      @required this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      DayWidget(
          dayName: "ПН",
          dayArr: workingTime.mon,
          isSelected: false,
          textSelectedColor: kColorWhite,
          textUnSelectedColor: kColorWhite,
          backColor: kColorWhite,
          fontSize: fontSize),
      divider(),
      DayWidget(
          dayName: "ВТ",
          dayArr: workingTime.mon,
          isSelected: false,
          textSelectedColor: kColorWhite,
          textUnSelectedColor: kColorWhite,
          backColor: kColorWhite,
          fontSize: fontSize),
      divider(),
      DayWidget(
          dayName: "СР",
          dayArr: workingTime.mon,
          isSelected: false,
          textSelectedColor: kColorWhite,
          textUnSelectedColor: kColorWhite,
          backColor: kColorWhite,
          fontSize: fontSize),
      divider(),
      DayWidget(
          dayName: "ЧТ",
          dayArr: workingTime.mon,
          isSelected: false,
          textSelectedColor: kColorWhite,
          textUnSelectedColor: kColorWhite,
          backColor: kColorWhite,
          fontSize: fontSize),
      divider(),
      DayWidget(
          dayName: "ПТ",
          dayArr: workingTime.mon,
          isSelected: false,
          textSelectedColor: kColorWhite,
          textUnSelectedColor: kColorWhite,
          backColor: kColorWhite,
          fontSize: fontSize),
      divider(),
      DayWidget(
          dayName: "СБ",
          dayArr: workingTime.mon,
          isSelected: false,
          textSelectedColor: kColorWhite,
          textUnSelectedColor: kColorWhite,
          backColor: kColorWhite,
          fontSize: fontSize),
      divider(),
      DayWidget(
          dayName: "ВС",
          dayArr: workingTime.mon,
          isSelected: false,
          textSelectedColor: kColorWhite,
          textUnSelectedColor: kColorWhite,
          backColor: kColorWhite,
          fontSize: fontSize),
    ]);
  }
}
