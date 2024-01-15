import 'package:control_data/app/core/repositories/user_repository.dart';
import 'package:control_data/app/core/views/register_user_page.dart';
import 'package:control_data/app/modules/auth/views/auth_page.dart';
import 'package:control_data/app/modules/auth/views/auth_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../home/home_module.dart';

class AuthModule extends Module {
  @override
  void binds(i) {
    super.binds(i);
    i.addLazySingleton<AuthStore>(AuthStore.new);
    i.add<UserRepository>(UserRepositoryImpl.new);
  }

  @override
  void routes(r) {
    super.routes(r);
    r.child(Modular.initialRoute, child: (_) => const AuthPage());
    r.child('/register', child: (_) => const RegisterUserPage());
    r.module('/home', module: HomeModule());
  }
}
