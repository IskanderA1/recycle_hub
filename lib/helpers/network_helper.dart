import 'dart:io';
import 'package:recycle_hub/api/request/request.dart';

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
}
