import 'package:control_data/app/modules/users/users_store.dart';
import 'package:control_data/app/modules/users/widgets/card_user_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class UsersPage extends StatelessWidget {
  UsersPage({Key? key}) : super(key: key);
  final _store = Modular.get<UsersStore>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {},
            child: const Text('Adicionar novo usuario'),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (ctx, index) {
                return const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: CardUserWidget(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
