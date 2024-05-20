import 'package:control_data/app/core/store/app_store.dart';
import 'package:control_data/app/core/utils/routes.dart';
import 'package:control_data/app/modules/users/views/users_store.dart';
import 'package:control_data/app/modules/users/views/widgets/card_user_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:skeletonizer/skeletonizer.dart';

class UsersPage extends StatelessWidget {
  UsersPage({super.key}) {
    _store.getAllUsers();
  }
  final _store = Modular.get<UsersStore>();
  final _appStore = Modular.get<AppStore>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Observer(builder: (context) {
        return Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Modular.to.pushNamed(routesPath.home.registerUser);
              },
              child: const Text('Adicionar novo usuario'),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: _store.usersList.isNotEmpty
                  ? Skeletonizer(
                      enabled: _appStore.loading,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _store.usersList.length,
                        itemBuilder: (ctx, index) {
                          var user = _store.usersList[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: CardUserWidget(user: user, store: _store),
                          );
                        },
                      ),
                    )
                  : const Center(
                      child: Text('Nenhum usuário registrada!'),
                    ),
            )
          ],
        );
      }),
    );
  }
}
