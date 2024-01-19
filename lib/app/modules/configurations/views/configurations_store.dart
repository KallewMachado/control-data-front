// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';

part 'configurations_store.g.dart';

class ConfigurationsStore = ConfigurationsStoreBase with _$ConfigurationsStore;

abstract class ConfigurationsStoreBase with Store {}
