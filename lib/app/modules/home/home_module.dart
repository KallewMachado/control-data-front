import 'package:control_data/app/modules/home/views/home_page.dart';
import 'package:control_data/app/modules/home/views/home_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton(HomeStore.new);
  }

  @override
  void routes(r) {
    r.child(Modular.initialRoute, child: (_) => const HomePage());
  }
}
