import 'package:control_data/app/modules/users/views/users_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

import '../../../../core/model/user_model.dart';

class CardUserWidget extends StatelessWidget {
  const CardUserWidget({super.key, required this.user, required this.store});
  final UserModel user;
  final UsersStore store;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;
    DateTime dateBirth = user.dateBirth;
    var date = DateFormat('dd/MM/yyyy');
    return Card(
      child: ListTile(
        onTap: () {
          Modular.to.pushNamed('/home/demands/');
        },
        shape: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: 1,
            color: theme.outlineVariant,
          ),
        ),
        leading: const Icon(Icons.person),
        title: Text(user.name),
        subtitle: Text(date.format(dateBirth)),
        trailing: IconButton(
          onPressed: () async {
            await store.deleteUser(user.id);
          },
          icon: const Icon(Icons.delete),
          color: Colors.red,
        ),
      ),
    );
  }
}
