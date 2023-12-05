import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await FlutterConfig.loadEnvVariables();

  await Supabase.initialize(
    url: FlutterConfig.get('supabaseUrl'),
    anonKey: FlutterConfig.get('supabaseAnonKey'),
  );

  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
