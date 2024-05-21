import 'package:mobx/mobx.dart';

import 'home_page.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  @observable
  Set<Pages> selection = <Pages>{Pages.initial};

  @action
  changeSelectionPage(Set<Pages> newSelection) {
    selection = newSelection;
  }
}
