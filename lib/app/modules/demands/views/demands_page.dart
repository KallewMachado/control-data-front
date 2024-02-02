import 'package:control_data/app/modules/demands/views/demands_store.dart';
import 'package:control_data/app/modules/demands/views/widgets/card_user_info_widget.dart';
import 'package:control_data/app/modules/demands/views/widgets/list_demands_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/model/user_model.dart';

class DemandsPage extends StatefulWidget {
  const DemandsPage({super.key, required this.user});

  final UserModel user;

  @override
  State<DemandsPage> createState() => _DemandsPageState();
}

class _DemandsPageState extends State<DemandsPage> {
  final _store = Modular.get<DemandsStore>();
  @override
  void initState() {
    _store.getAllDemandsByUser(widget.user.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Modular.to.pushNamed('./register', arguments: widget.user);
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: Column(
          children: [
            CardUserInfoWidget(user: widget.user),
            const SizedBox(height: 10),
            Divider(height: 10, color: theme.primary),
            const SizedBox(height: 10),
            ListDemandsWidget(store: _store)
          ],
        ),
      ),
    );
  }
}
