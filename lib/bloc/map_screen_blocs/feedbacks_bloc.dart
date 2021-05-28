import 'package:recycle_hub/model/map_responses/feedbacks_collection_response.dart';
import 'package:recycle_hub/api/google_map_repo.dart';
import 'package:rxdart/rxdart.dart';

class FeedBacksBloc {
  GoogleMapRepo _repo = GoogleMapRepo();
  BehaviorSubject<FeedBackCollectionResponse> _behaviorSubject =
      BehaviorSubject<FeedBackCollectionResponse>();

  FeedBackCollectionResponseLoading defaultItem =
      FeedBackCollectionResponseLoading();

  Stream<FeedBackCollectionResponse> get stream => _behaviorSubject.stream;

  pickEvent(FeedBackCollectionResponse type) {
    _behaviorSubject.sink.add(type);
  }

  loadFeedBacks() async {
    _behaviorSubject.sink.add(FeedBackCollectionResponseLoading());
    var _response = await _repo.getFeedBacks();
    print(_response);
    _behaviorSubject.sink.add(_response);
  }

  close() {
    _behaviorSubject.close();
  }
}

FeedBacksBloc feedBacksBloc = FeedBacksBloc();
