import 'package:control_data/app/modules/auth/views/auth_page.dart';
import 'package:control_data/app/modules/auth/views/auth_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module {
  @override
  void binds(i) {
    super.binds(i);
    i.addLazySingleton(AuthStore.new);
  }

  @override
  void routes(r) {
    super.routes(r);
    r.child(Modular.initialRoute, child: (_) => const AuthPage());
  }
}
