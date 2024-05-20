import 'dart:async';
import 'dart:developer' as developer;

import 'package:control_data/app/core/utils/routes.dart';
import 'package:control_data/app/modules/auth/views/auth_store.dart';
import 'package:control_data/app/modules/users/views/users_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../../core/store/app_store.dart';
import '../../../core/views/widgets/custom_dialog_widget.dart';
import 'home_store.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({super.key, this.title = 'Home'});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum Pages {
  initial(title: 'Inicio'),
  users(title: 'Usuarios'),
  config(title: 'Configuração');

  const Pages({required this.title});
  final String title;
}

class _HomePageState extends State<HomePage> {
  final HomeStore store = Modular.get<HomeStore>();
  final UsersStore usersStore = Modular.get<UsersStore>();
  final AppStore _appStore = Modular.get<AppStore>();
  final AuthStore authStore = Modular.get<AuthStore>();
  Set<Pages> selection = <Pages>{Pages.initial};

  late StreamSubscription<InternetConnectionStatus> listener;

  final customInstance = InternetConnectionChecker.createInstance(
    checkInterval: const Duration(seconds: 3),
  );

  @override
  void initState() {
    super.initState();

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
            selection.first.title,
            style: theme.textTheme.titleLarge,
          ),
          centerTitle: true),
      body: const RouterOutlet(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SegmentedButton<Pages>(
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
          setState(() {
            selection = newSelection;
            Modular.to.navigate('${routesPath.auth.home}$router/');
          });
        },
        multiSelectionEnabled: false,
      ),
    );
  }
}
