import 'package:control_data/app/core/model/user_model.dart';
import 'package:control_data/app/core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

class CardUserInfoWidget extends StatefulWidget {
  const CardUserInfoWidget({super.key, required this.user});
  final UserModel user;

  @override
  State<CardUserInfoWidget> createState() => _CardUserInfoWidgetState();
}

class _CardUserInfoWidgetState extends State<CardUserInfoWidget> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;
    var user = widget.user;
    var date = DateFormat('dd/MM/yyyy');

    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: theme.primary.withOpacity(0.2)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    '${user.name.split(' ').first} ${user.name.split(' ').last}'),
                Text(user.email),
                Text(user.cpf ?? ''),
                Text(user.street),
                Text(user.district),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    '${(DateTime.now().difference(user.dateBirth).inDays / 365).round()} anos'),
                Text(user.fone),
                Text(date.format(user.dateBirth)),
                Text(user.num),
                Text(user.complement ?? '')
              ],
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                Modular.to.pushNamed(routesPath.changeUser, arguments: user);
              },
              icon: const Icon(Icons.edit),
            ),
          ],
        ),
      ),
    );
  }
}
