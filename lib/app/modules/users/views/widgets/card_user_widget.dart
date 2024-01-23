import 'package:control_data/app/modules/users/views/users_store.dart';
import 'package:flutter/material.dart';
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
    return ListTile(
      shape: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(width: 1.5),
      ),
      leading: const Icon(Icons.person),
      title: Text(user.name),
      subtitle: Text(date.format(dateBirth)),
      trailing: const Icon(
        Icons.delete,
        color: Colors.red,
      ),
    );
  }
}
