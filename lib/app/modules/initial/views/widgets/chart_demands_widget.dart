import 'package:flutter/material.dart';

class ChartDemandsWidget extends StatelessWidget {
  const ChartDemandsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      height: 150,
      child: const Center(child: Text('Grafico de demandas')),
    );
  }
}
