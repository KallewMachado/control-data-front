import 'package:hive_flutter/hive_flutter.dart';

import '../model/user_model.dart';

class HiveConfig {
  final Box<UserModel> userBox = Hive.box('userBox');

  static Future<void> hiveStart() async {
    await Hive.initFlutter();
    _registerAdapters();
    await _openBoxes();
  }

  // static Future<void> _initHive() async {
  //   Directory appDocDir = await getApplicationDocumentsDirectory();
  //   String appDocPath = appDocDir.path;
  //   await Hive.initFlutter(appDocPath);
  // }

  static Future<void> _openBoxes() async {
    await Hive.openBox<UserModel>('userBox');
  }

  static _registerAdapters() {
    Hive.registerAdapter(UserModelAdapter());
  }

  Future<void> clearHive() async {
    await userBox.clear();
  }
}
