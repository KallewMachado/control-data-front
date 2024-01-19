import 'package:control_data/app/core/store/app_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ConfigurationsPage extends StatelessWidget {
  ConfigurationsPage({Key? key}) : super(key: key);

  final _appStore = Modular.get<AppStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(builder: (context) {
        return Column(children: [
          Text(
            'Thema',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          RadioListTile<ThemeMode>(
            title: const Text('Sistema'),
            value: ThemeMode.system,
            groupValue: _appStore.themeMode,
            onChanged: (mode) {
              if (mode != null) {
                _appStore.themeMode = mode;
              }
            },
          ),
          RadioListTile<ThemeMode>(
            title: const Text('Escuro'),
            value: ThemeMode.dark,
            groupValue: _appStore.themeMode,
            onChanged: (mode) {
              _appStore.themeMode = mode;
            },
          ),
          RadioListTile<ThemeMode>(
            title: const Text('Claro'),
            value: ThemeMode.light,
            groupValue: _appStore.themeMode,
            onChanged: (mode) {
              _appStore.themeMode = mode;
            },
          )
        ]);
      }),
    );
  }
}
