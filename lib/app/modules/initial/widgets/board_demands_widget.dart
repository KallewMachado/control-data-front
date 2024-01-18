import 'package:flutter/material.dart';

class BoardDemandsWidget extends StatelessWidget {
  const BoardDemandsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.blue,
        child: const Center(child: Text('Lista de demandas')),
      ),
    );
  }
}
