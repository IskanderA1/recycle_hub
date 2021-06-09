part of 'store_bloc.dart';

abstract class StoreState extends Equatable {
  const StoreState();

  @override
  List<Object> get props => [];
}

class StoreStateLoading extends StoreState {}

class StoreStateLoaded extends StoreState {
  StoreStateLoaded({this.serviceProducts, this.toEatProducts});

  final List<Product> serviceProducts;
  final List<Product> toEatProducts;

  @override
  List<Object> get props => [serviceProducts, toEatProducts];
}

class StoreStateBought extends StoreState {
  StoreStateBought({this.purchase});

  final Purchase purchase;

  @override
  List<Object> get props => [purchase];
}

class StoreStateError extends StoreState {
  StoreStateError({this.error});
  final Error error;

  @override
  List<Object> get props => [error];
}
