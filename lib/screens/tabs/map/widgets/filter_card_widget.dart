import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycle_hub/model/map_models.dart/accept_types.dart';
import 'package:recycle_hub/screens/tabs/map/methods/icon_data_method.dart';
import 'package:recycle_hub/style/theme.dart';
import 'package:recycle_hub/custom_icons.dart';
import 'dialog_container.dart';

class FilterCardWidget extends StatelessWidget {
  final FilterType acceptType;
  final Function(FilterType type) onpressed;
  final Function(FilterType type) onUp;
  final bool tapable;
  final bool isSelected;
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (tapable) {
          if (isSelected) {
            onUp(acceptType);
          } else {
            onpressed(acceptType);
          }
        }
      },
      child: Container(
        height: 60,
        width: 100,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? kColorGreen : Color(0xFFF2F2F2),
              width: 1,
            ),
            color: Color(0xFFF2F2F2),
            borderRadius: BorderRadius.circular(kBorderRadius)),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return DialogContainer(acceptType: acceptType);
                      });
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 5, right: 5),
                  child: Container(
                    height: 30,
                    width: 30,
                    child: Icon(
                      Icons.info_outline,
                      color: isSelected ? Colors.green : kColorGreyDark,
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
                    getIconData(acceptType.varName),
                    size: size / 6,
                    color: isSelected ? kColorGreen : Color(0xFF616161),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  AutoSizeText(
                    acceptType.name,
                    style: TextStyle(color: isSelected ? kColorGreen : Color(0xFF616161)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
