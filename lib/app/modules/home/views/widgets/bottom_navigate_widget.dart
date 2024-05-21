import 'package:control_data/app/modules/home/views/home_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/utils/enum.dart';
import '../../../../core/utils/routes.dart';

class BottomNavigateWidget extends StatelessWidget {
  const BottomNavigateWidget({super.key, required this.store});

  final HomeStore store;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return SegmentedButton<Pages>(
        showSelectedIcon: false,
        segments: _listPages,
        selected: store.selection,
        onSelectionChanged: onSelectionChanged,
        multiSelectionEnabled: false,
      );
    });
  }

  onSelectionChanged(Set<Pages> newSelection) {
    var router = newSelection.first.name;
    store.changeSelectionPage(newSelection);

    Modular.to.navigate('${routesPath.auth.home}$router/');
  }
}

var _listPages = <ButtonSegment<Pages>>[
  ButtonSegment<Pages>(value: Pages.initial, label: Text(Pages.initial.title)),
  ButtonSegment<Pages>(value: Pages.users, label: Text(Pages.users.title)),
  ButtonSegment<Pages>(value: Pages.config, label: Text(Pages.config.title)),
];
