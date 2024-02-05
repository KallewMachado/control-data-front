// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'app_store.g.dart';

class AppStore = AppStoreBase with _$AppStore;

abstract class AppStoreBase with Store {
  @observable
  ThemeMode? themeMode = ThemeMode.dark;

  @observable
  bool hasInternet = false;

  @action
  toggleHasInternetStatus(bool value) {
    hasInternet = value;
  }
}
