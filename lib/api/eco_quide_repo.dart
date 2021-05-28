import 'package:dio/dio.dart';
import 'package:recycle_hub/model/eco_guide_models/filter_model.dart';
import 'package:recycle_hub/model/eco_guide_models/filter_response.dart';

class EcoGuideRepository {
  String containerMainUrl = "eco.loliallen.com/";
  Dio _dio;
  EcoGuideRepository() {
    _dio = Dio(BaseOptions(baseUrl: containerMainUrl));
  }

  Future<FilterResponse> getFilters() async {
    String customUrl = "api/filters";
    try {
      // Response response = await _dio.get(customUrl);
      List response = [
        {
          "_id": {"oid": "600bec9edeab63dca5c85ab2"},
          "name": "Бумага",
          "var_name": "paper",
          "key_words": [
            "Газета",
            "Журнал",
            "Документы",
            "Тетради",
            "Макулатура"
          ],
          "bad_words": ["Упаковка сока", "Обои", "Фотографии"]
        },
        {
          "_id": {"oid": "600bec9edeab63dca5c85ab3"},
          "name": "Пластик",
          "var_name": "plastic",
          "key_words": [
            "Пищевая плёнка",
            "Баночки из под майонеза",
            "Бутылки",
            "Канистры",
          ],
          "bad_words": [
            "Бутылки из подсолнечного масла",
            "Упаковка для яиц",
            "Упаковка из под тортов"
          ]
        },
        {
          "_id": {"oid": "600bec9edeab63dca5c85ab4"},
          "name": "Стекло",
          "var_name": "glass",
          "key_words": [
            "Бесцветные банки",
            "Косметические банки",
            "Бутылки от напитков",
          ],
          "bad_words": [
            "Термостекло",
            "Телевизионные лампы",
            "Битое стекло",
            "Стекло автомобильное"
          ]
        },
        {
          "_id": {"oid": "600bec9edeab63dca5c85ab5"},
          "name": "Отходы",
          "var_name": "tails",
          "key_words": [
            "Пищевые",
            "Продукты",
            "Изношенная одежда",
          ],
          "bad_words": []
        },
        {
          "_id": {"oid": "600bec9edeab63dca5c85ab6"},
          "name": "Мусор",
          "var_name": "trash",
          "key_words": [
            "Пищевые",
            "Продукты",
            "Изношенная одежда",
          ],
          "bad_words": []
        },
      ];
      List<FilterModel> filterModel = [];
      for (int i = 0; i < response.length; i++) {
        filterModel.add(FilterModel.fromJson(response[i]));
      }
      return FilterResponse(filterModel,"");
    } catch (error, stack) {
      print("Error in getFilters: $error StackTrace: $stack");
      return FilterResponse.withError("Error getting filters");
    }
  }
}
