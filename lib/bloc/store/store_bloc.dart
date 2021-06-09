import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recycle_hub/api/request/api_error.dart';
import 'package:recycle_hub/api/services/store_service.dart';
import 'package:recycle_hub/model/product.dart';
import 'dart:developer' as dev;

import 'package:recycle_hub/model/purchase.dart';
part 'store_event.dart';
part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  StoreBloc() : super(StoreStateLoading());
  StoreService service = StoreService();

  @override
  Stream<StoreState> mapEventToState(
    StoreEvent event,
  ) async* {
    if (event is StoreEventInit) {
      yield* _mapInitToState();
    } else if (event is StoreEventBuy) {
      yield* _mapBuyToState(event);
    }
  }

  Stream<StoreState> _mapInitToState() async* {
    yield StoreStateLoading();
    try {
      final list = service.products;
      yield StoreStateLoaded(serviceProducts: list, toEatProducts: []);
    } on RequestError catch (e) {
      dev.log("RequestError ERROR ${e.description}", name: 'bloc.store_bloc');
      yield StoreStateError(error: e);
    } catch (e) {
      dev.log("ERROR ${e.toString()}", name: 'bloc.store_bloc');
      yield StoreStateError(error: e);
    }
  }

  Stream<StoreState> _mapBuyToState(StoreEventBuy event) async* {
    yield StoreStateLoading();
    try {
      final purchase = await service.buyProduct(event.product.id);
      if(purchase != null){
       yield StoreStateBought(purchase: purchase);
      }
    } on RequestError catch (e) {
      dev.log("RequestError ERROR ${e.description}", name: 'bloc.store_bloc');
      yield StoreStateError(error: e);
    } catch (e) {
      dev.log("ERROR ${e.toString()}", name: 'bloc.store_bloc');
      yield StoreStateError(error: e);
    }
  }
}
