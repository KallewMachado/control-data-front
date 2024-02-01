import 'package:control_data/app/modules/users/views/users_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/model/user_model.dart';
import '../../../../core/views/widgets/snackbar_widget.dart';

class CardUserWidget extends StatefulWidget {
  const CardUserWidget({super.key, required this.user, required this.store});
  final UserModel user;
  final UsersStore store;

  @override
  State<CardUserWidget> createState() => _CardUserWidgetState();
}

class _CardUserWidgetState extends State<CardUserWidget> {
  @override
  Widget build(BuildContext context) {
    DateTime dateBirth = widget.user.dateBirth;
    var date = DateFormat('dd/MM/yyyy');
    return Card(
      elevation: 5,
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 10),
        onTap: () {
          Modular.to.pushNamed('/home/demands/', arguments: widget.user);
        },
        leading: const Icon(Icons.person),
        title: Text(widget.user.name),
        subtitle: Text(date.format(dateBirth)),
        trailing: IconButton(
          onPressed: () async {
            try {
              await widget.store.deleteUser(widget.user.id);
              if (mounted) {
                SnackBarWidget.successSnackBar(
                    context, 'Usuário excluido com sucesso!');
              }
            } on PostgrestException catch (e) {
              if (mounted) {
                SnackBarWidget.errorSnackBar(context, e.message);
              }
            } catch (e) {
              if (mounted) {
                SnackBarWidget.errorSnackBar(context, e.toString());
              }
            }
          },
          icon: const Icon(Icons.delete),
          color: Colors.red,
        ),
      ),
    );
  }
}
