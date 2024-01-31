import 'package:control_data/app/modules/demands/views/demands_page.dart';
import 'package:control_data/app/modules/demands/views/register/register_demands_page.dart';
import 'package:control_data/app/modules/users/views/users_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DemandsModule extends Module {
  @override
  void binds(i) {
    super.binds(i);
    i.addLazySingleton<UsersStore>(UsersStore.new);
  }

  @override
  void routes(r) {
    super.routes(r);
    r.child(
      Modular.initialRoute,
      child: (context) => DemandsPage(
        user: r.args.data,
      ),
    );
    r.child(
      '/register',
      child: (context) => RegisterDemandsPage(
        user: r.args.data,
      ),
    );
  }
}
