import 'package:flutter/material.dart';
import 'package:recycle_hub/style/style.dart';

InputDecoration inputDecor(String hintStr) {
  return InputDecoration(
      border: InputBorder.none,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Colors.grey,
          width: 0.5,
        ),
      ),
      filled: true,
      fillColor: const Color(0xFFF2F4F7),
      hintText: hintStr,
      hintStyle: kHintTextStyle,
      // contentPadding: EdgeInsets.only(left: 16),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red, width: 1)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 0.5)),
      focusColor: const Color(0xFFF2F447),
);
}
