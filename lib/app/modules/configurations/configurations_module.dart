import 'package:flutter_modular/flutter_modular.dart';

import 'views/configurations_page.dart';

class ConfigurationsModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child(Modular.initialRoute, child: (_) => ConfigurationsPage());
  }
}
