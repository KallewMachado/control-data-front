import 'package:control_data/app/modules/initial/views/initial_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../demands/views/widgets/card_demands_widget.dart';

class BoardDemandsWidget extends StatelessWidget {
  BoardDemandsWidget({super.key}) {
    _store.getAllDemands();
  }
  final _store = Modular.get<InitialStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Expanded(
          child: ListView.builder(
            itemCount: _store.demandsList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: CardDemandsWidget(
                  demand: _store.demandsList[index],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
