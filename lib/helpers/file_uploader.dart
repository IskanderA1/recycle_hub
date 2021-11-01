import 'dart:io';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:recycle_hub/api/request/session_manager.dart';
import 'package:recycle_hub/helpers/messager_helper.dart';
import 'package:recycle_hub/screens/tabs/map/widgets/loader_widget.dart';
import 'package:recycle_hub/style/theme.dart';
import 'dart:developer' as d;
import 'package:http_parser/http_parser.dart';

class FileUpLoader {
  static const String devURL = "https://recyclehub.ru:5000/api/";
  static const String prodURL = "https://recyclehub.ru:5000/api/";

  static Future<void> sendPhoto(File file, String endpoint, [BuildContext context]) async {
    if (context != null) {
      _showLoader(context);
    }

    try {
      await _sendPhoto(file, endpoint, true);
    } catch (e) {
      d.log(e.toString(), name: 'helpers.file_uploader');
      if (context != null) {
        AlertHelper.showMessage(context: context, message: 'Не удалось отправить фото');
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

  static Future<void> sendPhotos(List<File> files, String endpoint, [BuildContext context]) async {
    if (context != null) {
      _showLoader(context);
    }

    try {
      files.forEach((element) async {
        try {
          await _sendPhoto(element, endpoint);
        } catch (e) {
          print(e.toString());
        }
      });
    } catch (e) {
      d.log(e.toString(), name: 'helpers.file_uploader');
      if (context != null) {
        AlertHelper.showMessage(context: context, message: 'Не удалось отправить фото');
      }
    }

    if (context != null) {
      _hideLoader(context);
    }
  }

  static Future<void> _sendPhoto(File file, String endpoint, [bool isProfileImage = false]) async {
    try {
      Dio dio = Dio(BaseOptions(baseUrl: devURL));
      String token = await SessionManager().getAuthorizationToken();
      if (token == null) {
        await SessionManager().relogin();
        token = await SessionManager().getAuthorizationToken();
      }
      if (token == null) {
        throw Exception('Пользователь не авторизован');
      }
      String fileName = file.path.split('/').last;
      FormData image = isProfileImage
          ? FormData.fromMap({
              'file': await MultipartFile.fromFile(
                file.path,
                filename: fileName,
                contentType: MediaType('image', 'jpg'),
              ),
            })
          : FormData.fromMap({
              'files': [
                await MultipartFile.fromFile(
                  file.path,
                  filename: fileName,
                  contentType: MediaType('image', 'jpg'),
                ),
              ]
            });
      final response = await dio.post(
        endpoint,
        data: image,
        options: Options(
          headers: {"Authorization": 'Bearer $token'},
          validateStatus: (status) {
            return status < 500;
          },
        ),
      );
      print('Image loaded: ${response.statusCode}');
      if (response.statusCode != 201) {
        print(response.statusMessage);
      } else {}
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
