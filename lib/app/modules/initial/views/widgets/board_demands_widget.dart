import 'package:control_data/app/modules/demands/views/demands_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../demands/views/widgets/card_demands_widget.dart';

class BoardDemandsWidget extends StatelessWidget {
  BoardDemandsWidget({super.key}) {
    _store.getAllDemands();
  }
  final _store = Modular.get<DemandsStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 80),
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
