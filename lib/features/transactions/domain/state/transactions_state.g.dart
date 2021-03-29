// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TransactionsState on TransactionsStateBase, Store {
  Computed<StoreState> _$stateComputed;

  @override
  StoreState get state =>
      (_$stateComputed ??= Computed<StoreState>(() => super.state,
              name: 'TransactionsStateBase.state'))
          .value;

  final _$_transactionsFutureAtom =
      Atom(name: 'TransactionsStateBase._transactionsFuture');

  @override
  ObservableFuture<Transactions> get _transactionsFuture {
    _$_transactionsFutureAtom.reportRead();
    return super._transactionsFuture;
  }

  @override
  set _transactionsFuture(ObservableFuture<Transactions> value) {
    _$_transactionsFutureAtom.reportWrite(value, super._transactionsFuture, () {
      super._transactionsFuture = value;
    });
  }

  final _$transactionsAtom = Atom(name: 'TransactionsStateBase.transactions');

  @override
  Transactions get transactions {
    _$transactionsAtom.reportRead();
    return super.transactions;
  }

  @override
  set transactions(Transactions value) {
    _$transactionsAtom.reportWrite(value, super.transactions, () {
      super.transactions = value;
    });
  }

  final _$statisticModelAtom =
      Atom(name: 'TransactionsStateBase.statisticModel');

  @override
  StatisticModel get statisticModel {
    _$statisticModelAtom.reportRead();
    return super.statisticModel;
  }

  @override
  set statisticModel(StatisticModel value) {
    _$statisticModelAtom.reportWrite(value, super.statisticModel, () {
      super.statisticModel = value;
    });
  }

  final _$errorMessageAtom = Atom(name: 'TransactionsStateBase.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$getTransactsAsyncAction =
      AsyncAction('TransactionsStateBase.getTransacts');

  @override
  Future<Transactions> getTransacts(String id) {
    return _$getTransactsAsyncAction.run(() => super.getTransacts(id));
  }

  @override
  String toString() {
    return '''
transactions: ${transactions},
statisticModel: ${statisticModel},
errorMessage: ${errorMessage},
state: ${state}
    ''';
  }
}
