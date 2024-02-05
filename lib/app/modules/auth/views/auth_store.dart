// ignore_for_file: library_private_types_in_public_api

import 'package:control_data/app/core/model/auth_model.dart';
import 'package:control_data/app/core/model/user_model.dart';
import 'package:control_data/app/core/repositories/user_repository.dart';
import 'package:control_data/app/core/utils/hive_config.dart';
import 'package:mobx/mobx.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {
  final UserRepository _userRepository;
  final hive = HiveConfig();

  @observable
  bool obscurePassword = true;

  _AuthStoreBase(this._userRepository);

  @action
  changeObscurePassword() {
    obscurePassword = !obscurePassword;
  }

  Future<AuthModel> createUser(AuthModel auth) async {
    try {
      return await _userRepository.createUser(auth);
    } on AuthException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> login(AuthModel auth) async {
    try {
      var user = await _userRepository.login(auth);
      await hive.userBox.clear();
      await hive.userBox.add(user);
      return user;
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @action
  Future<void> logout() async {
    try {
      await _userRepository.logout();
      await hive.userBox.clear();
    } on AuthException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
