import 'package:control_data/app/modules/auth/auth_module.dart';
import 'package:control_data/app/modules/auth/views/auth_store.dart';
import 'package:control_data/app/modules/users/views/users_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'core/repositories/user_repository.dart';
import 'core/store/app_store.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<AppStore>(AppStore.new);
    i.addLazySingleton<UsersStore>(UsersStore.new);
    i.addLazySingleton<AuthStore>(AuthStore.new);
    i.add<UserRepository>(UserRepositoryImpl.new);
  }

  @override
  void routes(r) {
    r.module(Modular.initialRoute, module: AuthModule());
  }
}
