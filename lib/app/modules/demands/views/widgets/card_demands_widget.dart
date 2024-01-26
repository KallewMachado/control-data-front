import 'package:flutter/material.dart';

class CardDemandsWidget extends StatelessWidget {
  const CardDemandsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 10),
        title: const Text('Demands'),
        subtitle: const Text(
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          'demands text demands text demands text demands text demands text demands text demands text demands text demands text demands text demands text',
        ),
        trailing: IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {},
        ),
      ),
    );
  }
}
