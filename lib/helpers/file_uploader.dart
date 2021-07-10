import 'dart:io';

import 'package:dio/dio.dart';

class FileUpLoader{
  
  static const String devURL = "https://167.172.105.146:5000/api";
  static const String prodURL = "https://167.172.105.146:5000/api";

  static Future<void> sendPhotos(List<File>files, String endpoint)async{
    try{
      Dio dio = Dio();
      FormData images = FormData();
    }catch(e){
      rethrow;
    }
  }
}