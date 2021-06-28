// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions_admin_panel_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AdminTransactionsState on TransactionsStateB, Store {
  final _$userTokenAtom = Atom(name: 'TransactionsStateB.userToken');

  @override
  String get userToken {
    _$userTokenAtom.reportRead();
    return super.userToken;
  }

  @override
  set userToken(String value) {
    _$userTokenAtom.reportWrite(value, super.userToken, () {
      super.userToken = value;
    });
  }

  final _$garbagesAtom = Atom(name: 'TransactionsStateB.garbages');

  @override
  ObservableList<GarbageTupple> get garbages {
    _$garbagesAtom.reportRead();
    return super.garbages;
  }

  @override
  set garbages(ObservableList<GarbageTupple> value) {
    _$garbagesAtom.reportWrite(value, super.garbages, () {
      super.garbages = value;
    });
  }

  final _$errorMessageAtom = Atom(name: 'TransactionsStateB.errorMessage');

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

  final _$loadingAtom = Atom(name: 'TransactionsStateB.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$imagesAtom = Atom(name: 'TransactionsStateB.images');

  @override
  List<File> get images {
    _$imagesAtom.reportRead();
    return super.images;
  }

  @override
  set images(List<File> value) {
    _$imagesAtom.reportWrite(value, super.images, () {
      super.images = value;
    });
  }

  final _$stateAtom = Atom(name: 'TransactionsStateB.state');

  @override
  AdmStoreState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(AdmStoreState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$createGarbageCollectionAsyncAction =
      AsyncAction('TransactionsStateB.createGarbageCollection');

  @override
  Future<void> createGarbageCollection() {
    return _$createGarbageCollectionAsyncAction
        .run(() => super.createGarbageCollection());
  }

  final _$TransactionsStateBActionController =
      ActionController(name: 'TransactionsStateB');

  @override
  void saveUserToken(String userToken) {
    final _$actionInfo = _$TransactionsStateBActionController.startAction(
        name: 'TransactionsStateB.saveUserToken');
    try {
      return super.saveUserToken(userToken);
    } finally {
      _$TransactionsStateBActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearUserToken() {
    final _$actionInfo = _$TransactionsStateBActionController.startAction(
        name: 'TransactionsStateB.clearUserToken');
    try {
      return super.clearUserToken();
    } finally {
      _$TransactionsStateBActionController.endAction(_$actionInfo);
    }
  }

  @override
  void saveFilterAndAmmount(GarbageTupple newElement) {
    final _$actionInfo = _$TransactionsStateBActionController.startAction(
        name: 'TransactionsStateB.saveFilterAndAmmount');
    try {
      return super.saveFilterAndAmmount(newElement);
    } finally {
      _$TransactionsStateBActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteFilterAndAmmount(int index) {
    final _$actionInfo = _$TransactionsStateBActionController.startAction(
        name: 'TransactionsStateB.deleteFilterAndAmmount');
    try {
      return super.deleteFilterAndAmmount(index);
    } finally {
      _$TransactionsStateBActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addImage(File image) {
    final _$actionInfo = _$TransactionsStateBActionController.startAction(
        name: 'TransactionsStateB.addImage');
    try {
      return super.addImage(image);
    } finally {
      _$TransactionsStateBActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteImage(File image) {
    final _$actionInfo = _$TransactionsStateBActionController.startAction(
        name: 'TransactionsStateB.deleteImage');
    try {
      return super.deleteImage(image);
    } finally {
      _$TransactionsStateBActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toState(AdmStoreState newState) {
    final _$actionInfo = _$TransactionsStateBActionController.startAction(
        name: 'TransactionsStateB.toState');
    try {
      return super.toState(newState);
    } finally {
      _$TransactionsStateBActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userToken: ${userToken},
garbages: ${garbages},
errorMessage: ${errorMessage},
loading: ${loading},
images: ${images},
state: ${state}
    ''';
  }
}
