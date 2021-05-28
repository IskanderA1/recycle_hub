import 'package:flutter/cupertino.dart';
import 'package:recycle_hub/model/user_model.dart';

class StaticData{
  static ValueNotifier<UserModel> user = ValueNotifier<UserModel>(null);
}