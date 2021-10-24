import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

import 'package:recycle_hub/features/transactions/domain/repository/repository.dart';
import 'package:recycle_hub/helpers/file_uploader.dart';
import '../../../../../model/garbage.dart';
part 'transactions_admin_panel_state.g.dart';

enum AdmStoreState { INIT, SCANNED, CREATED }

class AdminTransactionsState = TransactionsStateB with _$AdminTransactionsState;

abstract class TransactionsStateB with Store {
  TransactionsStateB(this._registrationRepository);

  final TransactionsRepository _registrationRepository;

  @observable
  String userToken;

  @observable
  var garbages = ObservableList<GarbageTupple>();

  @observable
  String errorMessage;

  @observable
  String message;

  @observable
  bool loading = false;

  @observable
  List<File> images = [];

  @observable
  AdmStoreState state = AdmStoreState.INIT;

  @action
  void saveUserToken(String userToken) {
    this.userToken = userToken;
    this.state = AdmStoreState.SCANNED;
  }

  @action
  void clearUserToken() {
    this.userToken = null;
    this.garbages = ObservableList<GarbageTupple>();
    this.state = AdmStoreState.INIT;
  }

  @action
  void saveFilterAndAmmount(GarbageTupple newElement) {
    this.garbages.add(newElement);
  }

  @action
  void deleteFilterAndAmmount(int index) {
    this.garbages.removeAt(index);
  }

  @action
  void addImage(File image) {
    this.images.add(image);
  }

  @action
  void deleteImage(File image) {
    this.images.remove(image);
  }

  @action
  void toState(AdmStoreState newState) {
    errorMessage = null;
    if (newState == AdmStoreState.INIT) {
      this.clearUserToken();
    }
    this.state = newState;
  }

  @action
  Future<void> createGarbageCollection() async {
    if (this.userToken == null && this.userToken.isEmpty) {
      errorMessage = "QR код пользователя не найден";
      return;
    }
    if (this.garbages.isEmpty) {
      errorMessage = "Добавьте вторсырье";
      return;
    }
    loading = true;
    try {
      errorMessage = null;
      try {
        final tr = await _registrationRepository.createGarbageCollect(userToken, garbages);
        if(tr != null){
          try {
            FileUpLoader.sendPhotos(images, 'recycle/${tr.id}/images');
          }catch (e) {
            print(e);
          }
        }
      } catch (e) {
        print(errorMessage = e.toString());
        errorMessage = e.toString();
        loading = false;
      }
      if (errorMessage == null) {
        this.state = AdmStoreState.CREATED;
        message = 'Успешно отправлено';
      }
    } catch (error) {
      errorMessage = error.toString();
      loading = false;
    }
    loading = false;
  }
}
