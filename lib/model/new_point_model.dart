import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:recycle_hub/model/map_models.dart/contact_model.dart';
import 'package:recycle_hub/model/map_models.dart/coord.dart';


class NewPoint{
  Coords coords;
  String description;
  Contact contacts;
  File image;
  NewPoint({
  @required this.coords, 
  @required this.description, 
  @required this.contacts,
  @required this.image});
}