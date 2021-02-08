import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycle_hub/custom_icons.dart';

IconData getIconData(String varName) {
  switch (varName) {
    case "makulatura":
      return LofOut.paper1;
    case "karton":
      return LofOut.karton;
    case "aluminiy":
      return LofOut.aluminiy;
    case "electronica":
      return LofOut.electrician;
    case "jelezo":
      return LofOut.iron;
    case "tetra pak":
      return LofOut.tetrapak;
    case "textil":
      return LofOut.textile;
    case "shiny":
      return LofOut.shina;
    case "drugoe":
      return FontAwesomeIcons.ellipsisH;
    case "elektronika":
      return LofOut.electrician;
    case "batarejka":
      return LofOut.battery;
    case "bumaga":
      return LofOut.paper1;
      break;
    default:
      return FontAwesomeIcons.ellipsisH;
  }
}
