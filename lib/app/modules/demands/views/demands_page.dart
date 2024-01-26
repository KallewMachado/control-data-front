import 'package:control_data/app/modules/demands/views/widgets/card_user_info_widget.dart';
import 'package:flutter/material.dart';

import 'widgets/card_demands_widget.dart';

class DemandsPage extends StatefulWidget {
  const DemandsPage({super.key});

  @override
  State<DemandsPage> createState() => _DemandsPageState();
}

class _DemandsPageState extends State<DemandsPage> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: Column(
          children: [
            const CardUserInfoWidget(),
            const SizedBox(height: 10),
            Divider(height: 10, color: theme.primary),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (ctx, index) {
                  return const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: CardDemandsWidget(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
