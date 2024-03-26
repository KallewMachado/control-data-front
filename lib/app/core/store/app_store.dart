import 'dart:io';

import 'package:control_data/app/core/utils/hive_config.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'app_store.g.dart';

class AppStore = AppStoreBase with _$AppStore;

abstract class AppStoreBase with Store {
  final hive = HiveConfig();

  @observable
  String appVersion = '';

  @observable
  String buildDate = 'Desconhecido';

  @observable
  ThemeMode? themeMode = ThemeMode.dark;

  @observable
  bool loading = true;

  @observable
  bool hasInternet = false;

  // @observable
  // bool timeItsOver = false;

  // @observable
  // Duration myDuration = const Duration(seconds: 360);

  // @observable
  // Timer? countdownTimer;

  AppStoreBase() {
    initTheme();
    if (Platform.isAndroid || Platform.isIOS || Platform.isFuchsia) {
      // final isDev = AppEnviroment.enviroment == Enviroment.dev ? true : false;

      PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
        // final tag = isDev == true ? 'Beta' : '';
        final appVersion = '${packageInfo.version} +${packageInfo.buildNumber}';

        setAppVesion(appVersion);
      });
    }
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
  setAppVesion(String value) {
    appVersion = value;
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

  //  @action
  // setTime() {
  //   const int timerCounter = 360;

  //   countdownTimer?.cancel();

  //   var restTime = DateTime.now().difference(dateBox.get('timeRequest') ??
  //       DateTime.now().add(const Duration(seconds: ((timerCounter + 1) * -1))));

  //   if (restTime.inSeconds <= timerCounter && !restTime.inSeconds.isNegative) {
  //     myDuration = Duration(seconds: timerCounter - restTime.inSeconds);
  //   } else {
  //     myDuration = const Duration(seconds: 0);
  //   }

  //   countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
  //     final seconds = myDuration.inSeconds - 1;
  //     if (myDuration.inSeconds > 0) {
  //       myDuration = Duration(seconds: seconds);
  //     } else {
  //       countdownTimer!.cancel();
  //       toggleTimeItsOver();
  //     }
  //   });
  // }
}
