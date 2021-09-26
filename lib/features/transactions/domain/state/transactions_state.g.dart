// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TransactionsState on TransactionsStateBase, Store {
  Computed<StoreState> _$stateComputed;

  @override
  StoreState get state => (_$stateComputed ??= Computed<StoreState>(() => super.state, name: 'TransactionsStateBase.state')).value;

  final _$_transactionsFutureAtom = Atom(name: 'TransactionsStateBase._transactionsFuture');

  @override
  ObservableFuture<List<Transaction>> get _transactionsFuture {
    _$_transactionsFutureAtom.reportRead();
    return super._transactionsFuture;
  }

  @override
  set _transactionsFuture(ObservableFuture<List<Transaction>> value) {
    _$_transactionsFutureAtom.reportWrite(value, super._transactionsFuture, () {
      super._transactionsFuture = value;
    });
  }

  final _$transactionsAtom = Atom(name: 'TransactionsStateBase.transactions');

  @override
  List<Transaction> get transactions {
    _$transactionsAtom.reportRead();
    return super.transactions;
  }

  @override
  set transactions(List<Transaction> value) {
    _$transactionsAtom.reportWrite(value, super.transactions, () {
      super.transactions = value;
    });
  }

  final _$statisticModelAtom = Atom(name: 'TransactionsStateBase.statisticModel');

  @override
  List<StatisticModel> get statisticModel {
    _$statisticModelAtom.reportRead();
    return super.statisticModel;
  }

  @override
  set statisticModel(List<StatisticModel> value) {
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

  final _$totalKGAtom = Atom(name: 'TransactionsStateBase.totalKG');

  @override
  double get totalKG {
    _$totalKGAtom.reportRead();
    return super.totalKG;
  }

  @override
  set totalKG(double value) {
    _$totalKGAtom.reportWrite(value, super.totalKG, () {
      super.totalKG = value;
    });
  }

  final _$summAtom = Atom(name: 'TransactionsStateBase.summ');

  @override
  double get summ {
    _$summAtom.reportRead();
    return super.summ;
  }

  @override
  set summ(double value) {
    _$summAtom.reportWrite(value, super.summ, () {
      super.summ = value;
    });
  }

  final _$getTransactsAsyncAction = AsyncAction('TransactionsStateBase.getTransacts');

  @override
  Future<List<Transaction>> getTransacts(DateTime from, DateTime to) {
    return _$getTransactsAsyncAction.run(() => super.getTransacts(from, to));
  }

  @override
  String toString() {
    return '''
transactions: ${transactions},
statisticModel: ${statisticModel},
errorMessage: ${errorMessage},
totalKG: ${totalKG},
summ: ${summ},
state: ${state}
    ''';
  }
}
