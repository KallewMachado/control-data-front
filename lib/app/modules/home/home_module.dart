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
        ModuleRoute(
          '/initial',
          module: InitialModule(),
          transition: TransitionType.fadeIn,
          duration: const Duration(milliseconds: 500),
        ),
        ModuleRoute(
          '/users',
          module: UserModule(),
          transition: TransitionType.fadeIn,
          duration: const Duration(milliseconds: 500),
        ),
        ModuleRoute(
          '/config',
          module: ConfigurationsModule(),
          transition: TransitionType.fadeIn,
          duration: const Duration(milliseconds: 500),
        ),
      ],
    );
    r.child('/register/user', child: (_) => const RegisterUserPage());
    r.module('/demands', module: DemandsModule());
  }
}
