import 'package:recycle_hub/model/map_models.dart/markers_collection.dart';

class MarkersCollectionResponse {
  final MarkersCollection markers;
  MarkersCollectionResponse(var data)
      : this.markers = MarkersCollection.fromMap(data);

  MarkersCollectionResponse.withError() : markers = null;
  MarkersCollectionResponse.fromList(List list) : this.markers = MarkersCollection.fromList(list);
}

class MarkersCollectionResponseOk extends MarkersCollectionResponse {
  MarkersCollectionResponseOk(var data) : super(data);
  MarkersCollectionResponseOk.fromList(List list) : super.fromList(list);
}

class MarkerCollectionResponseWithError extends MarkersCollectionResponse {
  final String err;
  MarkerCollectionResponseWithError({this.err}) : super.withError();
}

class MarkerCollectionResponseEmptyList extends MarkersCollectionResponse {
  String err;
  MarkerCollectionResponseEmptyList({this.err}) : super.withError();
}

class MarkerCollectionResponseLoading extends MarkersCollectionResponse {
  MarkerCollectionResponseLoading() : super.withError();
}
