import 'package:control_data/app/modules/home/views/home_page.dart';
import 'package:control_data/app/modules/home/views/home_store.dart';
import 'package:control_data/app/modules/initial/initial_store.dart';
import 'package:control_data/app/modules/users/users_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../configurations/configurations_page.dart';
import '../initial/initial_page.dart';
import '../users/users_page.dart';

class HomeModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton(HomeStore.new);
    i.addLazySingleton(InitialStore.new);
    i.addLazySingleton(UsersStore.new);
  }

  @override
  void routes(r) {
    r.child(
      Modular.initialRoute,
      child: (_) => const HomePage(),
      children: [
        ChildRoute('/initial', child: (_) => const InitialPage()),
        ChildRoute('/voters', child: (context) => UsersPage()),
        ChildRoute('/config', child: (context) => ConfigurationsPage()),
      ],
    );
  }
}
