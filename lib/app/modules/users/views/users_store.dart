import 'package:control_data/app/core/repositories/user_repository.dart';
import 'package:control_data/app/core/utils/hive_config.dart';
import 'package:mobx/mobx.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/model/user_model.dart';

part 'users_store.g.dart';

class UsersStore = UsersStoreBase with _$UsersStore;

abstract class UsersStoreBase with Store {
  final UserRepository _repository;
  final hive = HiveConfig();

  @observable
  UserModel user = UserModel(
    id: '',
    name: 'name',
    email: 'email',
    dateBirth: DateTime(1997, 09, 18),
    fone: 'fone',
    street: 'street',
    num: 'num',
    district: 'district',
    complement: 'complement',
    userCreated: 'userCreated',
    demands: [],
    cpf: 'cpf',
  );

  ObservableList<UserModel> usersList = ObservableList<UserModel>();

  UsersStoreBase(this._repository) {
    initUser();
  }

  initUser() {
    var userbox = hive.userBox.values.first;

    user = UserModel(
      id: userbox.id,
      name: userbox.name,
      email: userbox.email,
      dateBirth: userbox.dateBirth,
      fone: userbox.fone,
      street: userbox.street,
      num: userbox.num,
      district: userbox.district,
      complement: userbox.complement ?? '',
      userCreated: userbox.userCreated,
      demands: userbox.demands ?? [],
      cpf: userbox.cpf,
    );
  }

  @action
  Future<void> getAllUsers() async {
    try {
      var users = await _repository.getAllUsers();
      usersList.clear();
      usersList.addAll(users);
    } on PostgrestException catch (e) {
      print(e.message);
    } catch (e) {
      print(e);
    }
  }
}
