import 'package:mobx/mobx.dart';

part 'initial_store.g.dart';

class InitialStore = InitialStoreBase with _$InitialStore;

abstract class InitialStoreBase with Store {
  InitialStoreBase();
}
