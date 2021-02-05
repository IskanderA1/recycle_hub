import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:recycle_hub/model/map_models.dart/accept_types.dart';
import 'package:recycle_hub/screens/tabs/map/methods/icon_data_method.dart';
import 'package:recycle_hub/style/theme.dart';

import 'dialog_container.dart';

class FilterCardWidget extends StatefulWidget {
  final AcceptType acceptType;
  const FilterCardWidget(
      {Key key, @required this.size, @required this.acceptType})
      : super(key: key);

  final double size;

  @override
  _FilterCardWidgetState createState() => _FilterCardWidgetState();
}

class _FilterCardWidgetState extends State<FilterCardWidget> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_isSelected) {
          setState(() {
            _isSelected = false;
          });
        } else {
          setState(() {
            _isSelected = true;
          });
        }
      },
      child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(
                color: _isSelected ? kColorGreen : Color(0xFFF2F2F2),
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
                      color: Colors.green,
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
                    size: widget.size / 5,
                    color: _isSelected ? kColorGreen : Color(0xFF616161),
                  ),
                  AutoSizeText(
                    widget.acceptType.name,
                    style: TextStyle(
                        color: _isSelected ? kColorGreen : Color(0xFF616161)),
                  )
                ],
              ),
            ),
          ])),
    );
  }
}
