import 'package:recycle_hub/features/transactions/data/local/service/local_service.dart';

class LocalModule {
  static LocalService _localService;
  static LocalService getModule() {
    if (_localService == null) {
      _localService = LocalService();
    }
    return _localService;
  }
}
