import 'package:control_data/app/modules/demands/views/demands_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'card_demands_widget.dart';

class ListDemandsWidget extends StatefulWidget {
  const ListDemandsWidget({super.key, required this.store});
  final DemandsStore store;

  @override
  State<ListDemandsWidget> createState() => _ListDemandsWidgetState();
}

class _ListDemandsWidgetState extends State<ListDemandsWidget> {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Expanded(
          child: widget.store.demandsListByUser.isNotEmpty
              ? ListView.builder(
                  padding: const EdgeInsets.only(bottom: 80),
                  itemCount: widget.store.demandsListByUser.length,
                  itemBuilder: (ctx, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: CardDemandsWidget(
                        demand: widget.store.demandsListByUser[index],
                        store: widget.store,
                      ),
                    );
                  },
                )
              : const Center(
                  child: Text('Usuário não possui demandas registrada!'),
                ),
        );
      },
    );
  }
}
