import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/utils/routes.dart';
import '../home_page.dart';

class BottomNavigateWidget extends StatelessWidget {
  const BottomNavigateWidget({super.key, required this.selection});
  final Set<Pages> selection;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Pages>(
      style: ButtonStyle(
        side: MaterialStateProperty.all(
          const BorderSide(color: Colors.transparent),
        ),
      ),
      showSelectedIcon: false,
      segments: <ButtonSegment<Pages>>[
        ButtonSegment<Pages>(
            value: Pages.initial, label: Text(Pages.initial.title)),
        ButtonSegment<Pages>(
            value: Pages.users, label: Text(Pages.users.title)),
        ButtonSegment<Pages>(
            value: Pages.config, label: Text(Pages.config.title)),
      ],
      selected: selection,
      onSelectionChanged: (Set<Pages> newSelection) {
        var router = newSelection.first.name;

        Modular.to.navigate('${routesPath.auth.home}$router/');
      },
      multiSelectionEnabled: false,
    );
  }
}
