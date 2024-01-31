import 'package:control_data/app/core/model/demands_model.dart';
import 'package:control_data/app/modules/demands/views/demands_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CardDemandsWidget extends StatefulWidget {
  const CardDemandsWidget({super.key, required this.demand});
  final DemandsModel demand;

  @override
  State<CardDemandsWidget> createState() => _CardDemandsWidgetState();
}

class _CardDemandsWidgetState extends State<CardDemandsWidget> {
  final _store = Modular.get<DemandsStore>();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.demand.isDone == true ? Colors.green : null,
      elevation: 5,
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 10),
        title: Text(widget.demand.title),
        subtitle: Text(
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          widget.demand.description ?? '',
        ),
        trailing: PopupMenuButton(
          icon: const Icon(Icons.more_vert),
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(
              onTap: () {
                Map<String, dynamic> json = {"done": !widget.demand.isDone};

                _store.updateDemands(json, widget.demand.id);
              },
              child: Text(
                  widget.demand.isDone == false ? 'Finalizar' : 'Desfazer'),
            ),
            const PopupMenuItem(
              child: Text('Editar'),
            ),
            PopupMenuItem(
              enabled: widget.demand.isDone == true ? false : true,
              child: const Text('Remover'),
            ),
          ],
        ),
      ),
    );
  }
}
