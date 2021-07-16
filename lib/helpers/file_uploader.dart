import 'dart:io';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:recycle_hub/helpers/messager_helper.dart';
import 'package:recycle_hub/screens/tabs/map/widgets/loader_widget.dart';
import 'package:recycle_hub/style/theme.dart';
import 'dart:developer' as d;

class FileUpLoader {
  static const String devURL = "https://167.172.105.146:5000/api";
  static const String prodURL = "https://167.172.105.146:5000/api";

  static Future<void> sendPhoto(File file, String endpoint,
      [BuildContext context]) async {
    if (context != null) {
      _showLoader(context);
    }

    try {
      await _sendPhoto(file, endpoint);
    } catch (e) {
      d.log(e.toString(), name: 'helpers.file_uploader');
      if (context != null) {
        showMessage(context: context, message: 'Не удалось отправить фото');
      }
    }

    if (context != null) {
      _hideLoader(context);
    }
  }

  static void _showLoader(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Material(
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: kColorWhite,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Center(
                        child: LoaderWidget(),
                      ),
                    ),
                  ),
                )));
  }

  static void _hideLoader(BuildContext context) {
    Navigator.of(context).popUntil(ModalRoute.withName('/'));
  }

  static Future<void> sendPhotos(List<File> files, String endpoint,
      [BuildContext context]) async {
    if (context != null) {
      _showLoader(context);
    }

    try {
      files.forEach((element) {
        _sendPhoto(element, endpoint);
      });
    } on Exception catch (e) {
      d.log(e.toString(), name: 'helpers.file_uploader');
      if (context != null) {
        showMessage(context: context, message: 'Не удалось отправить фото');
      }
    }

    if (context != null) {
      _hideLoader(context);
    }
  }

  static Future<void> _sendPhoto(File file, String endpoint) async {
    try {
      Dio dio = Dio();
      FormData image = FormData.fromMap({'file': file});
      final response = await dio.post(devURL + '/' + endpoint, data: image);
      if (response.statusCode != 200) {}
    } catch (e) {
      rethrow;
    }
  }
}
