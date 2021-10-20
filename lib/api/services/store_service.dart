import 'dart:convert';

import 'package:recycle_hub/api/request/api_error.dart';
import 'package:recycle_hub/api/request/request.dart';
import 'package:recycle_hub/model/product.dart';
import 'dart:developer' as developer;

import 'package:recycle_hub/model/purchase.dart';

class StoreService {
  static StoreService _instance = StoreService._();

  StoreService._();

  factory StoreService() {
    return _instance;
  }

  List<Product> _products = [];

  List<Product> get products => _products;

  List<Purchase> _purchases = [];

  List<Purchase> get purchases => _purchases;

  Future<void> loadProducts() async {
    var response;
    try {
      response = await CommonRequest.makeRequest('products');
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        this._products = List<Product>.from(data?.map((e) => Product.fromMap(e)));
      } else {
        _products = [];
      }
    } catch (e) {
      developer.log("ERROR type ${e.runtimeType} ${e.toString()}", name: 'api.services.store_service');
      _products = [];
    }
  }

  Future<void> loadPurchases() async {
    var response;
    try {
      response = await CommonRequest.makeRequest('buy_product');
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        this._purchases = List<Purchase>.from(data?.map((e) => Purchase.fromMap(e)));
      } else {
        _purchases = [];
      }
    } catch (e) {
      developer.log("ERROR type ${e.runtimeType} ${e.toString()}", name: 'api.services.store_service');
      _purchases = [];
    }
  }

  Future<Purchase> buyProduct(String productId) async {
    try {
      var response = await CommonRequest.makeRequest('buy_product', method: CommonRequestMethod.post, body: {"product": productId});
      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var newPurchase = Purchase.fromJson(response.body);
        loadPurchases();
        return newPurchase;
      } else if (response.statusCode == 400) {
        /* if (data['error'] == "Not enought coins") {
          throw RequestError(
              response: response,
              description: "Недостаточно ЭкоКоинов",
              code: RequestErrorCode.notEnoughMoney);
        } else if (data["error"] == "product is over") { */
        throw RequestError(response: response, description: body['error'] ?? 'Что-то пошло не так', code: RequestErrorCode.productIsOver);
        /*  } */
      }
      throw RequestError(
        response: response,
        description: "Что-то пошло не так...",
      );
    } catch (e) {
      developer.log("ERROR type ${e.runtimeType} ${e.toString()}", name: 'api.services.store_service');
      rethrow;
    }
  }

  Future<Product> getProductById(String id) async {
    try {
      final response = await CommonRequest.makeRequest('products', body: {"product_id": id});
      if (response.statusCode == 200) {
        return Product.fromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      developer.log("ERROR type ${e.runtimeType} ${e.toString()}", name: 'api.services.store_service');
      return null;
    }
  }
}
