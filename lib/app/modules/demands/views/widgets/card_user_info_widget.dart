import 'package:flutter/material.dart';

class CardUserInfoWidget extends StatefulWidget {
  const CardUserInfoWidget({super.key});

  @override
  State<CardUserInfoWidget> createState() => _CardUserInfoWidgetState();
}

class _CardUserInfoWidgetState extends State<CardUserInfoWidget> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: theme.outlineVariant),
          color: theme.primaryContainer.withOpacity(0.5)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nome do Usuario'),
              Text('usuario@email.com'),
              Text('999.999.999-99'),
              Text('Rua nova'),
              Text('Centro'),
            ],
          ),
          const Spacer(),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('30 anos'),
              Text('(99) 9 9999-9999'),
              Text('10/10/1999'),
              Text('342'),
            ],
          ),
          const Spacer(),
          IconButton(onPressed: () {}, icon: const Icon(Icons.edit))
        ],
      ),
    );
  }
}
