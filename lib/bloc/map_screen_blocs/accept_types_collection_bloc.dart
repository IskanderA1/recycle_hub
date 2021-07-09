import 'package:recycle_hub/api/services/points_service.dart';
import 'package:recycle_hub/model/map_responses/accept_types_collection_response.dart';
import 'package:recycle_hub/api/google_map_repo.dart';
import 'package:rxdart/rxdart.dart';

class AcceptTypesCollectionBloc {
  PointsService _service = PointsService();
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
    _service.getAcceptTypes().then((value) {
      _behaviorSubject.sink.add(value);
      return value;
      });
  }

  close() {
    _behaviorSubject.close();
  }
}

AcceptTypesCollectionBloc acceptTypesCollectionBloc =
    AcceptTypesCollectionBloc();
