import 'package:control_data/app/core/store/app_store.dart';
import 'package:control_data/app/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appStore = Modular.get<AppStore>();
    return Observer(builder: (context) {
      return MaterialApp.router(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        title: 'Control Data',
        themeMode: appStore.themeMode,
        theme: lightTheme,
        darkTheme: darkTheme,
        routerConfig: Modular.routerConfig,
      );
    });
  }
}
