// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppStore on AppStoreBase, Store {
  late final _$appVersionAtom =
      Atom(name: 'AppStoreBase.appVersion', context: context);

  @override
  String get appVersion {
    _$appVersionAtom.reportRead();
    return super.appVersion;
  }

  @override
  set appVersion(String value) {
    _$appVersionAtom.reportWrite(value, super.appVersion, () {
      super.appVersion = value;
    });
  }

  late final _$buildDateAtom =
      Atom(name: 'AppStoreBase.buildDate', context: context);

  @override
  String get buildDate {
    _$buildDateAtom.reportRead();
    return super.buildDate;
  }

  @override
  set buildDate(String value) {
    _$buildDateAtom.reportWrite(value, super.buildDate, () {
      super.buildDate = value;
    });
  }

  late final _$themeModeAtom =
      Atom(name: 'AppStoreBase.themeMode', context: context);

  @override
  ThemeMode? get themeMode {
    _$themeModeAtom.reportRead();
    return super.themeMode;
  }

  @override
  set themeMode(ThemeMode? value) {
    _$themeModeAtom.reportWrite(value, super.themeMode, () {
      super.themeMode = value;
    });
  }

  late final _$loadingAtom =
      Atom(name: 'AppStoreBase.loading', context: context);

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

  late final _$hasInternetAtom =
      Atom(name: 'AppStoreBase.hasInternet', context: context);

  @override
  bool get hasInternet {
    _$hasInternetAtom.reportRead();
    return super.hasInternet;
  }

  @override
  set hasInternet(bool value) {
    _$hasInternetAtom.reportWrite(value, super.hasInternet, () {
      super.hasInternet = value;
    });
  }

  late final _$handleThemeModelAsyncAction =
      AsyncAction('AppStoreBase.handleThemeModel', context: context);

  @override
  Future<void> handleThemeModel(ThemeMode? theme) {
    return _$handleThemeModelAsyncAction
        .run(() => super.handleThemeModel(theme));
  }

  late final _$AppStoreBaseActionController =
      ActionController(name: 'AppStoreBase', context: context);

  @override
  dynamic initFetch() {
    final _$actionInfo = _$AppStoreBaseActionController.startAction(
        name: 'AppStoreBase.initFetch');
    try {
      return super.initFetch();
    } finally {
      _$AppStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic endFetch() {
    final _$actionInfo = _$AppStoreBaseActionController.startAction(
        name: 'AppStoreBase.endFetch');
    try {
      return super.endFetch();
    } finally {
      _$AppStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic initTheme() {
    final _$actionInfo = _$AppStoreBaseActionController.startAction(
        name: 'AppStoreBase.initTheme');
    try {
      return super.initTheme();
    } finally {
      _$AppStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setAppVesion(String value) {
    final _$actionInfo = _$AppStoreBaseActionController.startAction(
        name: 'AppStoreBase.setAppVesion');
    try {
      return super.setAppVesion(value);
    } finally {
      _$AppStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic toggleHasInternetStatus(bool value) {
    final _$actionInfo = _$AppStoreBaseActionController.startAction(
        name: 'AppStoreBase.toggleHasInternetStatus');
    try {
      return super.toggleHasInternetStatus(value);
    } finally {
      _$AppStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
appVersion: ${appVersion},
buildDate: ${buildDate},
themeMode: ${themeMode},
loading: ${loading},
hasInternet: ${hasInternet}
    ''';
  }
}
