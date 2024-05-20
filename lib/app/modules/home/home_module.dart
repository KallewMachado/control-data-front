import 'package:control_data/app/modules/home/views/home_page.dart';
import 'package:control_data/app/modules/home/views/home_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/views/register_user_page.dart';
import '../configurations/configurations_module.dart';
import '../demands/demands_module.dart';
import '../initial/initial_module.dart';
import '../users/user_module.dart';

class HomeModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<HomeStore>(HomeStore.new);
  }

  @override
  void routes(r) {
    r.child(
      Modular.initialRoute,
      child: (_) => const HomePage(),
      children: [
        ModuleRoute('/initial', module: InitialModule()),
        ModuleRoute('/users', module: UserModule()),
        ModuleRoute('/config', module: ConfigurationsModule()),
      ],
    );
    r.child('/register/user', child: (_) => const RegisterUserPage());
    r.module('/demands', module: DemandsModule());
  }
}
