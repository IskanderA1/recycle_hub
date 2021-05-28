import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:recycle_hub/model/map_models.dart/accept_types.dart';
import 'package:recycle_hub/model/map_models.dart/coord.dart';
import 'package:recycle_hub/model/map_models.dart/filter_model.dart';
import 'package:recycle_hub/model/map_responses/accept_types_collection_response.dart';
import 'package:recycle_hub/model/map_responses/feedbacks_collection_response.dart';
import 'package:recycle_hub/model/map_responses/markers_response.dart';
import 'package:http/http.dart' as http;

import '../model/map_models.dart/marker.dart';

class GoogleMapRepo {
  static String mainUrl = "http://eco.loliallen.com";
  Box box;
  GoogleMapRepo(){
   openBox();
  }

  openBox() async {
     box = await Hive.openBox('markers');
  }

  Future<MarkersCollectionResponse> loadMarkersFrom4Coords(LatLng latLng, double zoom) async {
    Coords x1, x2, x3, x4;
    if(zoom > 10){
      x1 = Coords(lat: latLng.latitude -0.5, lng: latLng.longitude+0.5);
      x2 = Coords(lat: latLng.latitude +0.5, lng: latLng.longitude+0.5);
      x3 = Coords(lat: latLng.latitude +0.5, lng: latLng.longitude-0.5);
      x4 = Coords(lat: latLng.latitude -0.5, lng: latLng.longitude-0.5);
    }
    try {
      Hive.openBox('markers');
      DateTime lastDownLoad = Hive.box('markers').get('lastTime', defaultValue: DateTime(2020, 12, 21));
      Duration dur = DateTime.now().difference(lastDownLoad);
      if(dur < Duration(minutes: 1)){
        List<CustMarker> localList = List<CustMarker>.from(Hive.box('markers').get('markersList', defaultValue: List<CustMarker>.empty()));
      if(localList.isNotEmpty){
        print("Маркеры загружены из локального хранилища");
        return MarkersCollectionResponseOk.fromList(localList);
      }
      }
      
      print("Запрос отправлен");
      var response = await http.get("$mainUrl/api/rec_points?coords=[[${x1.lat}, ${x1.lng}],[${x2.lat}, ${x2.lng}],[${x3.lat}, ${x3.lng}],[${x4.lat}, ${x4.lng}]]");
      List<dynamic> data = jsonDecode(response.body);
      print(data);
      if (data.isNotEmpty) {
        List<CustMarker> list = List<CustMarker>.from(data.map((marker) => CustMarker.fromMap(marker)));
        box.put('markersList', list);
        Hive.box('markers').put('lastTime', DateTime.now());
        return MarkersCollectionResponseOk.fromList(list);
      } else {
        return MarkerCollectionResponseWithError(err: "Список пуст");
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MarkerCollectionResponseWithError(err: "Нет сети");
    }
  }

  Future<MarkersCollectionResponse> getMarkersByFilter(
      MapFilterModel model) async {
    try {
      Hive.openBox('markers');
      Hive.openBox('markers');
      DateTime lastDownLoad = Hive.box('markers').get('lastTime', defaultValue: DateTime(2020, 12, 21));
      Duration dur = DateTime.now().difference(lastDownLoad);
      if(dur < Duration(minutes: 60)){
        List<CustMarker> localList = List<CustMarker>.from(Hive.box('markers').get('markersList', defaultValue: List<CustMarker>.empty()));
        if(model.recType != null && model.paybackType != null){
          localList = localList.where((element) => element.paybackType==model.paybackType && element.receptionType == model.recType).toList();
        }
        if(model.filters.isNotEmpty)
        {
          for(String filter in model.filters){
            localList = localList.where((element) {
            for(AcceptType item in element.acceptTypes){
              if(item.varName == filter) return true;
            }
            return false;
            }).toList();
          }
        }
        print("Маркеры загружены из локального хранилища");
        return MarkersCollectionResponseOk.fromList(localList);
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
      if (model.recType != null && model.paybackType != null ){
        response = await http.get(
            "$mainUrl/api/rec_points?coords=[[33, 33],[60, 33],[60, 60],[33, 60]]&rec_type=" +
                model.recType +
                "&payback_type=" +
                model.paybackType +
                "&filters=$_filters");
      } else {
        response = await http.get(
            "$mainUrl/api/rec_points?coords=[[33, 33],[60, 33],[60, 60],[33, 60]]&filters=$_filters");
      }
      var data = jsonDecode(response.body);
      print(data);
      if (data.isNotEmpty) {
        return MarkersCollectionResponseOk(data);
      } else {
        return MarkerCollectionResponseEmptyList(err: "Список пуст");
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MarkerCollectionResponseWithError(err: "Нет сети");
    }
  }

  Future<AcceptTypesCollectionResponse> getAcceptTypes() async {
    String _url = "/api/filters";
    try {
      print("Запрос отправлен");
      var response = await http.get("$mainUrl$_url");
      var data = jsonDecode(response.body);
      print(data);
      if (data.isNotEmpty) {
        return AcceptTypesCollectionResponseOk(response.body);
      } else {
        return AcceptTypesCollectionResponseWithError("Список пуст");
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return AcceptTypesCollectionResponseOk(error.toString());
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
}
