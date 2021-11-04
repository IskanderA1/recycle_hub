import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

enum MODE { PAID, FREE, PARTNERS, unknown }

class MarkerWorkModeCubit extends Cubit<MODE> {
  MarkerWorkModeCubit() : super(MODE.unknown);

  pickEvent(MODE type) {
    if (state == type) {
      emit(MODE.unknown);
    } else {
      emit(type);
    }
  }
}
