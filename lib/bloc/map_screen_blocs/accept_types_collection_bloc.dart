import 'package:recycle_hub/model/map_responses/accept_types_collection_response.dart';
import 'package:recycle_hub/repo/google_map_repo.dart';
import 'package:rxdart/rxdart.dart';

class AcceptTypesCollectionBloc {
  GoogleMapRepo _repo = GoogleMapRepo();
  BehaviorSubject<AcceptTypesCollectionResponse> _behaviorSubject =
      BehaviorSubject<AcceptTypesCollectionResponse>();

  AcceptTypesCollectionResponseLoading defaultItem =
      AcceptTypesCollectionResponseLoading();

  Stream<AcceptTypesCollectionResponse> get stream => _behaviorSubject.stream;

  pickEvent(AcceptTypesCollectionResponse type) {
    _behaviorSubject.sink.add(type);
  }

  Future<AcceptTypesCollectionResponse> loadAcceptTypes() async {
    _behaviorSubject.sink.add(AcceptTypesCollectionResponseLoading());
    var _response = await _repo.getAcceptTypes();
    _behaviorSubject.sink.add(_response);
    return _response;
  }

  close() {
    _behaviorSubject.close();
  }
}

AcceptTypesCollectionBloc acceptTypesCollectionBloc =
    AcceptTypesCollectionBloc();