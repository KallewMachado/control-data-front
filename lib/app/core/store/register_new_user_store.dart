// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';

part 'register_new_user_store.g.dart';

class RegisterNewUserStore = _RegisterNewUserStoreBase
    with _$RegisterNewUserStore;

abstract class _RegisterNewUserStoreBase with Store {
  @observable
  bool obscurePassword = true;

  @observable
  bool obscureConfirmPassword = true;

  @action
  changeObscurePassword() {
    obscurePassword = !obscurePassword;
  }

  @action
  changeObscureConfirmPassword() {
    obscureConfirmPassword = !obscureConfirmPassword;
  }
}
