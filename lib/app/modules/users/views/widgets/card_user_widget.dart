import 'dart:developer' as developer;
import 'package:control_data/app/core/store/app_store.dart';
import 'package:control_data/app/modules/users/views/users_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/model/user_model.dart';
import '../../../../core/views/widgets/custom_dialog_widget.dart';
import '../../../../core/views/widgets/snackbar_widget.dart';

class CardUserWidget extends StatefulWidget {
  const CardUserWidget({super.key, required this.user, required this.store});
  final UserModel user;
  final UsersStore store;

  @override
  State<CardUserWidget> createState() => _CardUserWidgetState();
}

class _CardUserWidgetState extends State<CardUserWidget> {
  _deleteUser() {
    developer.log(
      'run [Delete User] ==> ',
      name: 'auth_page.dart',
    );
    CustomDialogWidet.show(
      context,
      title: (context) =>
          const Text(' Tem certeza que deseja excluir usuario?'),
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
            try {
              await widget.store.deleteUser(widget.user.id);
              if (mounted) {
                SnackBarWidget.successSnackBar(
                    context, 'Usuário excluido com sucesso!');
              }
              Modular.to.pop();
            } on PostgrestException catch (e) {
              Modular.to.pop();
              SnackBarWidget.errorSnackBar(context, e.message);
            } catch (e) {
              Modular.to.pop();
              if (appStore.hasInternet == false) {
                CustomDialogWidet.show(
                  context,
                  content: (context) => const Text(
                      'falha na conexão, verifique sua conexão com a internet e tente novamente'),
                );
              } else {
                SnackBarWidget.errorSnackBar(context, e.toString());
              }
            }
          },
          child: const Text('Sim'),
        ),
      ],
    );
  }

  final appStore = Modular.get<AppStore>();
  @override
  Widget build(BuildContext context) {
    DateTime dateBirth = widget.user.dateBirth;
    var userbox = widget.store.hive.userBox.values.first;
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
        trailing: widget.user.id != userbox.id
            ? IconButton(
                onPressed: _deleteUser,
                icon: const Icon(Icons.delete),
                color: Colors.red,
              )
            : null,
      ),
    );
  }
}
