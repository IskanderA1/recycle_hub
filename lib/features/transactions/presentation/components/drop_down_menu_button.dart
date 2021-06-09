import 'package:flutter/material.dart';
import 'package:recycle_hub/style/theme.dart';

class DropDownMenuChildButton extends StatelessWidget {
  const DropDownMenuChildButton({
    Key key,
    @required String selectedItem,
  })  : _selectedItem = selectedItem,
        super(key: key);

  final String _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFFF7F7F7), borderRadius: BorderRadius.circular(20)),
      width: 120,
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
              width: 15,
              height: 20,
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