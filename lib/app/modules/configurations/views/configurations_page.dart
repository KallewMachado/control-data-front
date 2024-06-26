import 'package:control_data/app/core/store/app_store.dart';
import 'package:control_data/app/core/utils/routes.dart';
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
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Observer(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Thema',
                  style: textTheme.titleLarge,
                ),
                RadioListTile<ThemeMode>(
                  title: const Text('Escuro'),
                  value: ThemeMode.dark,
                  groupValue: _appStore.themeMode,
                  onChanged: _appStore.handleThemeModel,
                ),
                RadioListTile<ThemeMode>(
                  title: const Text('Claro'),
                  value: ThemeMode.light,
                  groupValue: _appStore.themeMode,
                  onChanged: _appStore.handleThemeModel,
                ),
                Text(
                  "User",
                  style: textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                OutlinedButton(
                  onPressed: () {
                    Modular.to.pushNamed(routesPath.changePassword);
                  },
                  child: const Text("Alterar senha"),
                ),
                const SizedBox(height: 30),
                TextButton.icon(
                  onPressed: () async {
                    WidgetsBinding.instance.addPostFrameCallback(
                      (timeStamp) {
                        CustomDialogWidet.show(
                          context,
                          title: (context) =>
                              const Text(' Tem certeza que deseja sair?'),
                          content: (context) => const SizedBox(height: 0),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Modular.to.pop();
                              },
                              child: const Text('Não'),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                Modular.to.pop();
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
                              child: const Text('Sim'),
                            ),
                          ],
                        );
                      },
                    );
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
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(_appStore.appVersion),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
