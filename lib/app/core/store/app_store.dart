import 'dart:ffi';

import 'package:control_data/app/core/utils/hive_config.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'app_store.g.dart';

class AppStore = AppStoreBase with _$AppStore;

abstract class AppStoreBase with Store {
  final hive = HiveConfig();

  @observable
  ThemeMode? themeMode = ThemeMode.dark;

  @observable
  bool loading = true;

  @observable
  bool hasInternet = false;

  AppStoreBase() {
    initTheme();
  }

  @action
  initFetch() {
    loading = true;
  }

  @action
  endFetch() {
    loading = false;
  }

  @action
  initTheme() {
    if (hive.themeBox.get('darkMode') == null) return;
    themeMode =
        hive.themeBox.get('darkMode') ? ThemeMode.dark : ThemeMode.light;
  }

  @action
  Future<void> handleThemeModel(ThemeMode? theme) async {
    if (theme == null) return;
    if (theme.name == 'dark') {
      await hive.themeBox.put('darkMode', true);
    }
    if (theme.name == 'light') {
      await hive.themeBox.put('darkMode', false);
    }
    themeMode = theme;
  }

  @action
  toggleHasInternetStatus(bool value) {
    hasInternet = value;
  }
}
