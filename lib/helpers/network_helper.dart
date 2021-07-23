import 'dart:io';
import 'package:flutter/material.dart';
import 'package:recycle_hub/api/request/request.dart';
import 'package:recycle_hub/helpers/messager_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class NetworkHelper {
  static Future<bool> checkNetwork() async {
    Uri uri = Uri.tryParse(CommonRequest.apiURL);

    try {
      final result = await InternetAddress.lookup(uri.host);
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } catch (e) {
      print("Error while checking internet connection: $e");
      return false;
    }
    return false;
  }

  static void openUrl(String url, BuildContext context) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        universalLinksOnly: true,
      );
    } else {
      showMessage(context: context, message: "Ошибка при попытке открыть ссылку");
    }
  }
}
