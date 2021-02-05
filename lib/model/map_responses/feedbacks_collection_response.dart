import 'package:recycle_hub/model/map_models.dart/feedbackers_collection_model.dart';

class FeedBackCollectionResponse {
  FeedBackerCollectionModel feeds;
  String error;

  FeedBackCollectionResponse.fromJson(var sourse)
      : feeds = FeedBackerCollectionModel.fromJson(sourse),
        error = "";

  FeedBackCollectionResponse.withError(String err)
      : feeds = null,
        error = err;

  FeedBackCollectionResponse()
      : feeds = null,
        error = "";
}

class FeedBackCollectionResponseLoading extends FeedBackCollectionResponse {
  FeedBackCollectionResponseLoading() : super();
}

class FeedBackCollectionResponseWithError extends FeedBackCollectionResponse {
  FeedBackCollectionResponseWithError(String err) : super.withError(err);
}

class FeedBackCollectionResponseOk extends FeedBackCollectionResponse {
  FeedBackCollectionResponseOk(var sourse) : super.fromJson(sourse);
}
