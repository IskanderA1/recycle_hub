part of 'store_bloc.dart';

abstract class StoreEvent extends Equatable {
  const StoreEvent();

  @override
  List<Object> get props => [];
}

class StoreEventInit extends StoreEvent {
  @override
  List<Object> get props => [];
}

class StoreEventBuy extends StoreEvent {
  StoreEventBuy({this.product});
  final Product product;
  @override
  List<Object> get props => [product];
}
