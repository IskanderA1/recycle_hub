import 'package:recycle_hub/model/map_models.dart/coord.dart';
import 'package:recycle_hub/model/map_models.dart/markers_collection.dart';
import 'package:recycle_hub/model/map_responses/markers_response.dart';
import 'package:recycle_hub/repo/google_map_repo.dart';
import 'package:rxdart/rxdart.dart';

enum Mode { INFO, FEEFBACK }

class MarkerInfoFeedBloc {
  BehaviorSubject<Mode> _behaviorSubject = BehaviorSubject<Mode>();

  Mode defaultItem = Mode.INFO;

  Stream<Mode> get stream => _behaviorSubject.stream;

  pickEvent(Mode type) {
    _behaviorSubject.sink.add(type);
  }

  close() {
    _behaviorSubject.close();
  }
}

MarkerInfoFeedBloc markerInfoFeedBloc = MarkerInfoFeedBloc();
