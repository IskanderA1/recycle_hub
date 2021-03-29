import 'package:recycle_hub/features/transactions/data/api/api_util.dart';
import 'package:recycle_hub/features/transactions/data/api/service/service.dart';

class ApiModule{
  static ApiUtil _apiUtil;

  static ApiUtil getModule(){
    if(_apiUtil == null){
      _apiUtil = ApiUtil(ApiTransactionsService());
    }
    return _apiUtil;
  }
}