import 'package:control_data/app/core/store/app_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/views/widgets/custom_dialog_widget.dart';
import '../../auth/views/auth_store.dart';

class ConfigurationsPage extends StatelessWidget {
  ConfigurationsPage({super.key});

  final _appStore = Modular.get<AppStore>();
  final _authStore = Modular.get<AuthStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              ),
              Text(
                "User",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () {
                  Modular.to.pushNamed('/changePassword');
                },
                child: const Text("Alterar senha"),
              ),
              const SizedBox(height: 30),
              TextButton.icon(
                onPressed: () async {
                  CustomDialogWidet.show(
                    context,
                    barrierDismissible: false,
                    actions: [],
                    content: (context) => const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Saindo...'),
                        SizedBox(height: 10),
                        CircularProgressIndicator(),
                      ],
                    ),
                  );

                  await _authStore.logout();
                  Modular.to.navigate('/');
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                label: const Text(
                  'Sair',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
