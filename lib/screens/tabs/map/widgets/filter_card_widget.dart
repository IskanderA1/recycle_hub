import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycle_hub/model/map_models.dart/accept_types.dart';
import 'package:recycle_hub/screens/tabs/map/methods/icon_data_method.dart';
import 'package:recycle_hub/style/theme.dart';
import 'package:recycle_hub/custom_icons.dart';
import 'dialog_container.dart';

class FilterCardWidget extends StatefulWidget {
  final AcceptType acceptType;
  final Function onpressed;
  final Function onUp;
  final bool tapable;
  bool isSelected;
  FilterCardWidget(
      {Key key,
      @required this.size,
      @required this.acceptType,
      @required this.onpressed,
      @required this.onUp,
      @required this.tapable,
      @required this.isSelected})
      : super(key: key);

  final double size;

  @override
  FilterCardWidgetState createState() => FilterCardWidgetState();
}

class FilterCardWidgetState extends State<FilterCardWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.tapable) {
          if (widget.isSelected) {
            widget.onUp(widget.acceptType.varName);
            setState(() {
              widget.isSelected = false;
            });
          } else {
            pressFunc();
          }
        }
      },
      child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(
                color: widget.isSelected ? kColorGreen : Color(0xFFF2F2F2),
                width: 2,
              ),
              color: Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(15)),
          child: Stack(children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return DialogContainer(acceptType: widget.acceptType);
                      });
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 5, right: 5),
                  child: Container(
                    height: 30,
                    width: 30,
                    child: Icon(
                      Icons.info_outline,
                      color: widget.isSelected ? Colors.green : kColorGreyDark,
                      size: 25,
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    getIconData(widget.acceptType.varName),
                    size: widget.size / 6,
                    color: widget.isSelected ? kColorGreen : Color(0xFF616161),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  AutoSizeText(
                    widget.acceptType.name,
                    style: TextStyle(
                        color: widget.isSelected
                            ? kColorGreen
                            : Color(0xFF616161)),
                  )
                ],
              ),
            ),
          ])),
    );
  }

  void pressFunc() {
    widget.onpressed(widget.acceptType.varName);
    setState(() {
      widget.isSelected = true;
    });
  }
}
