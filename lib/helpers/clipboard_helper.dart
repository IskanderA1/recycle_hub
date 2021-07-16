import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:recycle_hub/helpers/messager_helper.dart';
import 'package:recycle_hub/style/theme.dart';

saveToCache(String str, BuildContext context) {
  try {
    Clipboard.setData(ClipboardData(text: "$str"));
    showMessage(context: context, message: "Код скопирован в буфер обмена",
    backColor: kColorGreen);
  } catch (e) {
    showMessage(context: context, message: "Ошибка");
  }
}
