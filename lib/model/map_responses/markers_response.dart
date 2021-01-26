import 'package:recycle_hub/model/map_models.dart/markers_collection.dart';

class MarkersCollectionResponseOk extends MarkersCollection {
  MarkersCollectionResponseOk(var data) : super.fromJson(data);
}

class MarkerCollectionResponseWithError extends MarkersCollection {
  final String err;
  MarkerCollectionResponseWithError({this.err});
}

class MarkerCollectionResponseLoading extends MarkersCollection {
  MarkerCollectionResponseLoading();
}
