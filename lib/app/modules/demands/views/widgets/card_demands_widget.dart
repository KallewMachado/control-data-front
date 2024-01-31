import 'package:control_data/app/core/model/demands_model.dart';
import 'package:flutter/material.dart';

class CardDemandsWidget extends StatelessWidget {
  const CardDemandsWidget({super.key, required this.demand});
  final DemandsModel demand;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: demand.isDone == true ? Colors.green : null,
      elevation: 5,
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 10),
        title: Text(demand.title),
        subtitle: Text(
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          demand.description ?? '',
        ),
        trailing: PopupMenuButton(
          icon: const Icon(Icons.more_vert),
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(
              child: Text(demand.isDone == false ? 'Finalizar' : 'Desfazer'),
            ),
            const PopupMenuItem(
              child: Text('Editar'),
            ),
            PopupMenuItem(
              enabled: demand.isDone == true ? false : true,
              child: const Text('Remover'),
            ),
          ],
        ),
      ),
    );
  }
}
