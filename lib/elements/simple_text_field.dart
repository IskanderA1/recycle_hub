import 'package:flutter/material.dart';
import 'package:recycle_hub/style/theme.dart';

class SimpleTextField extends StatelessWidget {
  final Function(String value) onChanged;
  final Function() onComplete;
  final Function(String value) onSubmitted;
  final String labelText;
  final String hintText;
  final TextInputType type;
  final TextEditingController controller;
  final bool readOnly;
  final int maxLines;

  SimpleTextField(
      {@required this.controller,
      this.labelText = '',
      this.hintText = '',
      this.type,
      this.onSubmitted,
      this.onChanged,
      this.onComplete,
      this.readOnly = false,
      this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Text(
            labelText,
            style: Theme.of(context).textTheme.headline6,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: SizedBox(
              height: 44.0 * maxLines,
              child: TextField(
                autofocus: false,
                keyboardType: type,
                controller: controller,
                onChanged: (value) {
                  if (onChanged != null) {
                    onChanged(value);
                  }
                },
                onSubmitted: (value) {
                  if (onSubmitted != null) {
                    onSubmitted(value);
                  }
                },
                onEditingComplete: () {
                  if (onComplete != null) {
                    onComplete();
                  }
                },
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(
                    fontSize: 14,
                    color: kColorBlack,
                    fontFamily: 'GilroyMedium'),
                readOnly: this.readOnly,
                maxLines: maxLines,
                decoration: InputDecoration(
                  hintText: hintText,

                  //labelText: labelText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(kBorderRadius),
                  ),
                  /* labelStyle: const TextStyle(
                        color: kColorGreyDark,
                        fontFamily: 'GilroyMedium',
                        fontSize: 14) */
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
