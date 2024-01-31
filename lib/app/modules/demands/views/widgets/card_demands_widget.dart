import 'package:control_data/app/core/model/demands_model.dart';
import 'package:flutter/material.dart';

class CardDemandsWidget extends StatelessWidget {
  const CardDemandsWidget({super.key, required this.demand});
  final DemandsModel demand;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 10),
        title: Text(demand.title),
        subtitle: Text(
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          demand.description ?? '',
        ),
        trailing: IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {},
        ),
      ),
    );
  }
}
