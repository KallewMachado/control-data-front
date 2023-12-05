// ignore_for_file: library_private_types_in_public_api

import 'package:control_data/app/core/model/auth_model.dart';
import 'package:control_data/app/core/repositories/user_repository.dart';
import 'package:mobx/mobx.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {
  final UserRepository _userRepository;
  _AuthStoreBase(this._userRepository);
  Future<void> createUser(AuthModel auth) async {
    try {
      await _userRepository.createUser(auth);
    } catch (e) {
      rethrow;
    }
  }
}
