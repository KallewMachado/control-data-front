import 'package:flutter/material.dart';

import 'widgets/board_demands_widget.dart';
import 'widgets/chart_demands_widget.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          children: [
            const ChartDemandsWidget(),
            const SizedBox(height: 20),
            const Text("Lista de Demandas"),
            const SizedBox(height: 10),
            BoardDemandsWidget()
          ],
        ),
      ),
    );
  }
}
