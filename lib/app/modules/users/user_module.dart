import 'package:control_data/app/core/repositories/user_repository.dart';
import 'package:control_data/app/modules/users/views/users_page.dart';
import 'package:control_data/app/modules/users/views/users_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/views/register_user_page.dart';

class UserModule extends Module {
  @override
  void binds(i) {
    super.binds(i);
    i.addLazySingleton<UsersStore>(UsersStore.new);
    i.add<UserRepository>(UserRepositoryImpl.new);
  }

  @override
  void routes(r) {
    super.routes(r);
    r.child(Modular.initialRoute, child: (context) => UsersPage());
    r.child('/register/user', child: (_) => const RegisterUserPage());
  }
}
