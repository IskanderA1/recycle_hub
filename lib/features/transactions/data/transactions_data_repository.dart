import 'dart:convert';
import 'package:recycle_hub/api/request/request.dart';
import 'package:recycle_hub/features/transactions/data/api/api_util.dart';
import 'package:recycle_hub/features/transactions/domain/repository/repository.dart';
import 'package:recycle_hub/model/garbage.dart';
import 'package:recycle_hub/model/transactions/transaction_model.dart';
import 'local/service/local_service.dart';
import 'package:recycle_hub/model/transactions/user_transaction_model.dart';

class TransactionsDataRepository extends TransactionsRepository {
  final ApiUtil apiUtil;
  final LocalService localService;
  TransactionsDataRepository(this.apiUtil, this.localService);

  @override
  Future<List<UserTransaction>> getUserTransactions() async {
    try {
      //var transacts = await localService.getTransactions();
      //if (transacts != null) return transacts;
      final transacts = await apiUtil.getUserTrensactions();
      //localService.putTransactions(transacts);
      return transacts;
    } catch (error) {
      rethrow;
    }
  }

  /*@override
  Future<List<Transaction>> filterTransactions(DateTime from, DateTime to) async {
    try {
      var transacts = await localService.getTransactions();
      if (transacts == null) {
        transacts = await apiUtil.getTransaction(id);
      }
      //transacts.list = transacts.
      return transacts;
    } catch (error) {
      rethrow;
    }
  }*/

  @override
  Future<void> createGarbageCollect(
      String userToken, List<GarbageTupple> items) async {
    try {
      var response = await CommonRequest.makeRequest("recycle",
          method: CommonRequestMethod.post,
          body: {
            "user_token": userToken,
            "items": items
                .map((e) => {
                      "filter_type": e.filterType.id,
                      "amount": e.ammount.toInt()
                    })
                .toList()
          });
      if (response.statusCode != 200) {
        print(jsonDecode(response.body));
        throw Exception("Не удалось отправить заявку");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Transaction>> getTransactions() async {
    try {
      var response = await CommonRequest.makeRequest('recycle');
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return List<Transaction>.from(data?.map((e) => Transaction.fromMap(e)));
      } else {
        throw Exception("Не удалось загрузить транзакции");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Transaction> getTransactionById(String recycleId) async {
    try {
      var response = await CommonRequest.makeRequest('recycle',
          params: {"recycle_id": recycleId});
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return Transaction.fromMap(data);
      } else {
        throw Exception("Не удалось загрузить транзакцию");
      }
    } catch (e) {
      rethrow;
    }
  }
}
