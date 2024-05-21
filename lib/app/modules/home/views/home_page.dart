import 'dart:async';
import 'dart:developer' as developer;

import 'package:control_data/app/core/utils/routes.dart';
import 'package:control_data/app/modules/home/views/home_store.dart';
import 'package:control_data/app/modules/home/views/widgets/bottom_navigate_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../../core/store/app_store.dart';
import '../../../core/views/widgets/custom_dialog_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.title = 'Home'});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final AppStore _appStore;
  late final HomeStore _homeStore;

  late StreamSubscription<InternetConnectionStatus> listener;

  final customInstance = InternetConnectionChecker.createInstance(
    checkInterval: const Duration(seconds: 3),
  );

  @override
  void initState() {
    super.initState();
    _appStore = Modular.get<AppStore>();
    _homeStore = Modular.get<HomeStore>();

    Modular.to.navigate(routesPath.home.initial);

    listener = customInstance.onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          developer.log(
            'run [InternetConnectionChecker()] ==> $status',
            name: 'auth_page.dart',
          );
          _appStore.toggleHasInternetStatus(true);

          break;
        case InternetConnectionStatus.disconnected:
          developer.log(
            'run [InternetConnectionChecker()] ==> $status',
            name: 'auth_page.dart',
          );
          _appStore.toggleHasInternetStatus(false);
          CustomDialogWidet.show(
            context,
            actions: [
              ElevatedButton(
                  onPressed: () async {
                    Modular.to.navigate(routesPath.home.path);
                  },
                  child: const Center(child: Text('Fechar')))
            ],
            content: (context) => const Text(
                'falha na conexão, verifique sua conexão com a internet e tente novamente'),
          );

          break;
      }
    });
  }

  @override
  void dispose() {
    listener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _homeStore.selection.first.title,
          style: theme.textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: const RouterOutlet(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BottomNavigateWidget(store: _homeStore),
    );
  }
}
