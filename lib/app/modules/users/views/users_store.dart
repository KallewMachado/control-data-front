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
  bool obscurePassword = true;

  @observable
  bool obscureConfirmPassword = true;

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
    adm: false,
  );

  ObservableList<UserModel> usersList = ObservableList<UserModel>();

  UsersStoreBase(this._repository) {
    initUser();
  }

  @action
  changeObscurePassword() {
    obscurePassword = !obscurePassword;
  }

  @action
  changeObscureConfirmPassword() {
    obscureConfirmPassword = !obscureConfirmPassword;
  }

  initUser() {
    if (hive.userBox.values.isEmpty) return;
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
      adm: userbox.adm,
    );
  }

  @action
  Future<UserModel> newUser(Map<String, dynamic> json) async {
    try {
      return await _repository.newUser(json);
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @action
  Future<void> failNewUser(String id) async {
    try {
      await _repository.failNewUser(id);
    } on PostgrestException catch (_) {
      rethrow;
    } on AuthException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @action
  Future<void> getAllUsers() async {
    try {
      var users = await _repository.getAllUsers();
      usersList.clear();
      usersList.addAll(users);
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @action
  Future<void> updateUser(Map<String, dynamic> json, String id) async {
    try {
      var response = await _repository.updateUser(json, id);

      usersList.removeWhere((user) => user.id == response.id);
      usersList.add(response);
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @action
  Future<void> deleteUser(String id) async {
    try {
      var user = await _repository.deleteUser(id);

      usersList.removeWhere((value) => value.id == user.id);
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updatePassword(String newPassword) async {
    try {
      await _repository.updatePassword(newPassword).whenComplete(() {});
    } on AuthException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> sendForgotPasswordFromEmail(String email) async {
    try {
      await _repository.sendForgotPasswordFromEmail(email);
    } on AuthException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> verifyOTP(String token, String email) async {
    try {
      await _repository.verifyOTP(token, email);
    } on AuthException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
