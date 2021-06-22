import 'package:flutter/material.dart';
import 'package:recycle_hub/style/theme.dart';

InputDecoration inputDecorWidget() {
  return InputDecoration(
      prefixIcon: Icon(
        Icons.search,
        color: Color(0xFF62C848),
        size: 30,
      ),
      hintText: "Что вы хотите сдать?",
      hintStyle: TextStyle(color: Color(0xFF62C848), fontSize: 16.0),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          borderSide: BorderSide(color: Color(0xFF62C848), width: 2.5)),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF62C848), width: 2.5),
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          borderSide: BorderSide(color: Color(0xFF62C848), width: 2.5)),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          borderSide: BorderSide(color: Color(0xFF62C848), width: 2.5)));
}

InputDecoration inputAdminPanelDecorWidget() {
  return InputDecoration(
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: kColorGreyLight, width: 1)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: kColorGreyLight, width: 1)),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: kColorGreyLight, width: 1)));
}

