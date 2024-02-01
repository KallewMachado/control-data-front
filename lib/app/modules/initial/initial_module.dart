import 'package:control_data/app/modules/initial/views/initial_page.dart';
import 'package:control_data/app/modules/initial/views/initial_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class InitialModule extends Module {
  @override
  void binds(i) {
    super.binds(i);
    i.addLazySingleton<InitialStore>(InitialStore.new);
  }

  @override
  void routes(r) {
    super.routes(r);
    r.child(Modular.initialRoute, child: (context) => const InitialPage());
  }
}
