import 'package:flutter/material.dart';
import 'package:recycle_hub/style/theme.dart';

class DropDownMenuChildButton extends StatelessWidget {
  final double width;
  const DropDownMenuChildButton({
    Key key,
    @required String selectedItem,
    this.width = 120,
  })  : _selectedItem = selectedItem,
        super(key: key);

  final String _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: kColorWhite, borderRadius: BorderRadius.circular(10)),
      width: width,
      height: 30,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
                child: Text(
              _selectedItem,
              overflow: TextOverflow.visible,
            )),
            const SizedBox(
              width: 20,
              height: 25,
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
