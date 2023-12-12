// ignore_for_file: library_private_types_in_public_api

import 'package:control_data/app/core/model/auth_model.dart';
import 'package:control_data/app/core/model/user_model.dart';
import 'package:control_data/app/core/repositories/user_repository.dart';
import 'package:mobx/mobx.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {
  final UserRepository _userRepository;

  _AuthStoreBase(this._userRepository);

  Future<AuthModel> createUser(AuthModel auth) async {
    try {
      return await _userRepository.createUser(auth);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> login(AuthModel auth) async {
    try {
      return await _userRepository.login(auth);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> newUser(Map<String, dynamic> json) async {
    try {
      return await _userRepository.newUser(json);
    } on PostgrestException catch (e) {
      rethrow;
    }
  }
}
