import 'dart:convert';
import 'package:recycle_hub/model/map_models.dart/accept_types_collection_model.dart';

class AcceptTypesCollectionResponse {
  AcceptTypesCollection acceptTypes;
  String error;
  AcceptTypesCollectionResponse({
    this.acceptTypes,
    this.error,
  });

  AcceptTypesCollectionResponse.fromMap(List<dynamic> map)
      : this.acceptTypes = AcceptTypesCollection.fromMap(map),
        this.error = "";

  /*AcceptTypesCollectionResponse.fromJson(var source) {
    AcceptTypesCollectionResponse.fromMap(json.decode(source));
  }*/

  AcceptTypesCollectionResponse.withError(String err) {
    acceptTypes = null;
    error = err;
  }
}

class AcceptTypesCollectionResponseLoading
    extends AcceptTypesCollectionResponse {
  AcceptTypesCollectionResponseLoading();
}

class AcceptTypesCollectionResponseWithError
    extends AcceptTypesCollectionResponse {
  AcceptTypesCollectionResponseWithError(String error) : super.withError(error);
}

class AcceptTypesCollectionResponseOk extends AcceptTypesCollectionResponse {
  AcceptTypesCollectionResponseOk(String sourse)
      : super.fromMap(json.decode(sourse));
}
