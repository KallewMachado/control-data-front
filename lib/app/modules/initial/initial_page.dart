import 'package:flutter/material.dart';

import 'widgets/board_demands_widget.dart';

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
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: Column(
          children: [
            Container(
              color: Colors.amber,
              height: 150,
              child: const Center(child: Text('Grafico de demandas')),
            ),
            const SizedBox(height: 20),
            const BoardDemandsWidget()
          ],
        ),
      ),
    );
  }
}
