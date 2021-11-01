import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:recycle_hub/helpers/messager_helper.dart';
import 'package:recycle_hub/style/theme.dart';

saveToCache(String str, BuildContext context) {
  try {
    Clipboard.setData(ClipboardData(text: "$str"));
    AlertHelper.showMessage(context: context, message: "Код скопирован в буфер обмена",
    backColor: kColorGreen);
  } catch (e) {
    AlertHelper.showMessage(context: context, message: "Ошибка");
  }
}
