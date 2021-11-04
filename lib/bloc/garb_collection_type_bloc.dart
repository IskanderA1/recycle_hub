import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

enum GCOLLTYPE { RECYCLING, UTILISATION, BENEFIT, unknown }

class GarbageCollectionTypeCubit extends Cubit<GCOLLTYPE> {
  GarbageCollectionTypeCubit() : super(GCOLLTYPE.unknown);

  pickEvent(GCOLLTYPE type) {
    if (state == type) {
      emit(GCOLLTYPE.unknown);
    } else {
      emit(type);
    }
  }
}
