import 'dart:convert';
import 'dart:io';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:recycle_hub/api/request/request.dart';
import 'package:recycle_hub/helpers/file_uploader.dart';
import 'package:recycle_hub/model/map_models.dart/accept_types.dart';
import 'package:recycle_hub/model/map_models.dart/filter_model.dart';
import 'package:recycle_hub/model/map_models.dart/marker.dart';
import 'package:recycle_hub/model/map_responses/feedbacks_collection_response.dart';
import 'dart:developer' as developer;

class PointsService {
  static PointsService _instance = PointsService._();
  static const _boxTimeKey = 'map.markers.lastTime';
  static const _boxTimeFiltersKey = 'map.markers.filtersLastTime';
  static const _boxFiltersListKey = 'map.markers.filtersList';
  static const _boxListKey = 'map.markers.list';
  static const _boxKey = 'map.markers';
  static const _devLog = 'api.services.map_service';
  Box _box;

  List<FilterType> filters = [];

  PointsService._() {
    openBox();
  }

  factory PointsService() {
    return _instance;
  }

  openBox() async {
    _box = await Hive.openBox(_boxKey);
  }

  Future<void> _checkBox() async {
    if (_box == null || !_box.isOpen) {
      _box = await Hive.openBox(_boxKey);
    }
  }

  Future<List<CustMarker>> loadMarkersFrom4Coords(LatLng latLng) async {
    await _checkBox();
    latLng = LatLng(55.796127, 49.106414);
    try {
      DateTime lastDownLoad =
          _box.get(_boxTimeKey, defaultValue: DateTime(2020, 12, 21));
      Duration dur = DateTime.now().difference(lastDownLoad);
      if (dur < Duration(minutes: 120)) {
        List<CustMarker> localList = List<CustMarker>.from(
            _box.get(_boxListKey, defaultValue: List<CustMarker>.empty()));
        if (localList.isNotEmpty) {
          developer.log("Маркеры загружены из локального хранилища",
              name: _devLog);
          return localList;
        }
      }

      print("Запрос отправлен");
      var response = await CommonRequest.makeRequest('rec_points',
          method: CommonRequestMethod.get,
          needAuthorization: false,
          body: {
            'size': '200',
            'page': '1',
            'position': "[" +
                latLng.latitude.toString() +
                ", " +
                latLng.longitude.toString() +
                "]",
            'radius': '100'
          });

      List<dynamic> data = jsonDecode(response.body)['data'];
      print(data);
      if (data.isNotEmpty) {
        List<CustMarker> list = List<CustMarker>.from(
            data.map((marker) => CustMarker.fromMap(marker)));
        list.add(list[0].copyWith(paybackType: 'partner', coords: [
          list[0].coords[0] + 0.00005,
          list[0].coords[1] + 0.00005
        ]));
        _box.put(_boxListKey, list);
        _box.put(_boxTimeKey, DateTime.now());
        return list;
      } else {
        throw Exception("Список пуст");
      }
    } catch (error, stacktrace) {
      developer.log("Exception occured: $error stackTrace: $stacktrace",
          name: _devLog);
      rethrow;
    }
  }

  Future<List<CustMarker>> getMarkersByFilter(MapFilterModel model) async {
    await _checkBox();
    try {
      DateTime lastDownLoad =
          _box.get(_boxTimeKey, defaultValue: DateTime(2020, 12, 21));
      Duration dur = DateTime.now().difference(lastDownLoad);
      if (dur < Duration(minutes: 60)) {
        List<CustMarker> localList = List<CustMarker>.from(
            _box.get(_boxListKey, defaultValue: List<CustMarker>.empty()));
        if (model.recType != null && model.paybackType != null) {
          localList = localList
              .where((element) =>
                  element.paybackType == model.paybackType &&
                  element.receptionType == model.recType)
              .toList();
        }
        List<CustMarker> filteredList = [];
        if (model.filters.isNotEmpty) {
          for (FilterType filter in model.filters) {
            localList.forEach((element) {
              if(element.acceptTypes.contains(filter.id)){
                filteredList.add(element);
              }
            });
          }
        }
        print("Маркеры загружены из локального хранилища");
        filteredList = filteredList.toSet().toList();
        return filteredList;
      }

      String _filters = '[';

      if (model.filters != null && model.filters.length != 0) {
        _filters = "['${model.filters[0]}'";
        for (int i = 1; i < model.filters.length; i++) {
          _filters = '$_filters' + ',' + "'${model.filters[i]}'";
        }
      }
      _filters = _filters + "]";
      print("Запрос отправлен");
      var response;
      /*print(
          "$mainUrl/api/rec_points?coords=[[33, 33],[60, 33],[60, 60],[33, 60]]&rec_type=" +
              model.recType +
              "&payback_type=" +
              model.paybackType +
              "&filters=$_filters");*/
      if (model.recType != null && model.paybackType != null) {
        response = await CommonRequest.makeRequest('rec_points',
            params: {'payback_type': model.recType, 'filters': _filters});
        /*await http.get(
            "$mainUrl/api/rec_points?coords=[[33, 33],[60, 33],[60, 60],[33, 60]]&rec_type=" +
                model.recType +
                "&payback_type=" +
                model.paybackType +
                "&filters=$_filters");*/
      } else {
        response = await CommonRequest.makeRequest('rec_points',
            params: {'filters': _filters});
        /*http.get(
            "$mainUrl/api/rec_points?coords=[[33, 33],[60, 33],[60, 60],[33, 60]]&filters=$_filters");*/
      }
      var data = jsonDecode(response.body);
      print(data);
      if (data.isNotEmpty) {
        return List<CustMarker>.from(data.map((e) {
          return CustMarker.fromMap(e);
        }));
      } else {
        return [];
      }
    } catch (error, stacktrace) {
      developer.log("Exception occured: $error stackTrace: $stacktrace",
          name: _devLog);
      rethrow;
    }
  }

  Future<List<FilterType>> loadAcceptTypes() async {
    await _checkBox();
    try {
      developer.log("Do GetAcceptTypes Request", name: _devLog);
      /*  DateTime lastLoadTime
      List<FilterType> localFilters = _box.get(_boxFiltersListKey); */
      var response =
          await CommonRequest.makeRequest('filters', needAuthorization: false);
      var data = jsonDecode(response.body);
      print(data);
      if (data.isNotEmpty) {
        filters = List<FilterType>.from(data.map((e) => FilterType.fromMap(e)));
        /* _box.put(_boxFiltersListKey, filters); */

        return filters;
      } else {
        return [];
      }
    } catch (error, stacktrace) {
      developer.log("Exception occured: $error stackTrace: $stacktrace",
          name: _devLog);
      return [];
    }
  }

  Future<FeedBackCollectionResponse> getFeedBacks() {
    var source = {
      "rating": 4.5,
      "feedBacks": [
        {
          'name': "Василий",
          'surname': "Бочкин",
          'feedBack':
              "Знаю много точек приёма металла, но именно здесьцена лучшая. Быстрый приём и сразу же деньги на руках. Рекомендую!",
          'hisFeedBacksCount': 54,
          'hisFeedBack': 3.4,
          'thumbsCount': 2,
          'dateOfFeedBack': "10 февраль 2021"
        },
        {
          'name': "Иван",
          'surname': "Иванов",
          'feedBack':
              "Знаю много точек приёма металла, но именно здесьцена лучшая. Быстрый приём и сразу же деньги на руках. Рекомендую!",
          'hisFeedBacksCount': 10,
          'hisFeedBack': 3.4,
          'thumbsCount': 12,
          'dateOfFeedBack': "4 январь 2021"
        },
        {
          'name': "Василий",
          'surname': "Бочкин",
          'feedBack':
              "Знаю много точек приёма металла, но именно здесьцена лучшая. Быстрый приём и сразу же деньги на руках. Рекомендую!",
          'hisFeedBacksCount': 54,
          'hisFeedBack': 3.4,
          'thumbsCount': 2,
          'dateOfFeedBack': "10 февраль 2021"
        },
        {
          'name': "Иван",
          'surname': "Иванов",
          'feedBack':
              "Знаю много точек приёма металла, но именно здесьцена лучшая. Быстрый приём и сразу же деньги на руках. Рекомендую!",
          'hisFeedBacksCount': 10,
          'hisFeedBack': 3.4,
          'thumbsCount': 12,
          'dateOfFeedBack': "4 январь 2021"
        },
      ],
    };
    print(source);
    //var data = json.encode(source);
    return Future.delayed(Duration(milliseconds: 300),
        () => FeedBackCollectionResponseOk(source));
  }

  Future<CustMarker> getPoint(String id) async {
    try {
      var response = await CommonRequest.makeRequest('rec_points/$id');
      var data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        return CustMarker.fromMap(data);
      } else
        return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> sendPointInfo(CustMarker point, List<File> images) async {
    try {
      final response = await CommonRequest.makeRequest('rec_points/${point.id}',
          method: CommonRequestMethod.put, body: point.toJson());
      var data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 202) {
        /* final imagesResponse = await CommonRequest.makeRequest('rec_offer/${point.id}/images',
        body: ); */
        FileUpLoader.sendPhotos(images, 'rec_points/${point.id}/images');
      } else {
        throw Exception('Не удалось сохранить изменения');
      }
    } catch (e) {
      developer.log(e.toString(), name: _devLog);
      rethrow;
    }
  }

  Future<void> sendImage(File image, String uri) async {}
}
