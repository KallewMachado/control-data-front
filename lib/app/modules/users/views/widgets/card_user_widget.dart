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
    DateTime dateBirth = user.dateBirth;
    var date = DateFormat('dd/MM/yyyy');
    return Card(
      elevation: 5,
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 10),
        shape: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        onTap: () {
          Modular.to.pushNamed('/home/demands/');
        },
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
