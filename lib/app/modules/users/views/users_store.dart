import 'package:mobx/mobx.dart';

import '../../../core/model/user_model.dart';

part 'users_store.g.dart';

class UsersStore = UsersStoreBase with _$UsersStore;

abstract class UsersStoreBase with Store {
  @observable
  List<UserModel> usersList = [];
}
