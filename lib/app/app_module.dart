import 'package:flutter_modular/flutter_modular.dart';

import 'core/store/app_store.dart';
import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<AppStore>(AppStore.new);
  }

  @override
  void routes(r) {
    r.module(Modular.initialRoute, module: HomeModule());
  }
}
