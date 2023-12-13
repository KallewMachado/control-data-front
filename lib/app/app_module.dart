import 'package:control_data/app/modules/auth/auth_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/auth/views/auth_store.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<AuthStore>(AuthStore.new);
  }

  @override
  void routes(r) {
    r.module('/', module: AuthModule());
  }
}
