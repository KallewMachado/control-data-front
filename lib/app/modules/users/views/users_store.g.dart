// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UsersStore on UsersStoreBase, Store {
  late final _$obscurePasswordAtom =
      Atom(name: 'UsersStoreBase.obscurePassword', context: context);

  @override
  bool get obscurePassword {
    _$obscurePasswordAtom.reportRead();
    return super.obscurePassword;
  }

  @override
  set obscurePassword(bool value) {
    _$obscurePasswordAtom.reportWrite(value, super.obscurePassword, () {
      super.obscurePassword = value;
    });
  }

  late final _$obscureConfirmPasswordAtom =
      Atom(name: 'UsersStoreBase.obscureConfirmPassword', context: context);

  @override
  bool get obscureConfirmPassword {
    _$obscureConfirmPasswordAtom.reportRead();
    return super.obscureConfirmPassword;
  }

  @override
  set obscureConfirmPassword(bool value) {
    _$obscureConfirmPasswordAtom
        .reportWrite(value, super.obscureConfirmPassword, () {
      super.obscureConfirmPassword = value;
    });
  }

  late final _$userAtom = Atom(name: 'UsersStoreBase.user', context: context);

  @override
  UserModel get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserModel value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$newUserAsyncAction =
      AsyncAction('UsersStoreBase.newUser', context: context);

  @override
  Future<UserModel> newUser(Map<String, dynamic> json) {
    return _$newUserAsyncAction.run(() => super.newUser(json));
  }

  late final _$failNewUserAsyncAction =
      AsyncAction('UsersStoreBase.failNewUser', context: context);

  @override
  Future<void> failNewUser(String id) {
    return _$failNewUserAsyncAction.run(() => super.failNewUser(id));
  }

  late final _$getAllUsersAsyncAction =
      AsyncAction('UsersStoreBase.getAllUsers', context: context);

  @override
  Future<void> getAllUsers() {
    return _$getAllUsersAsyncAction.run(() => super.getAllUsers());
  }

  late final _$updateUserAsyncAction =
      AsyncAction('UsersStoreBase.updateUser', context: context);

  @override
  Future<void> updateUser(Map<String, dynamic> json, String id) {
    return _$updateUserAsyncAction.run(() => super.updateUser(json, id));
  }

  late final _$deleteUserAsyncAction =
      AsyncAction('UsersStoreBase.deleteUser', context: context);

  @override
  Future<void> deleteUser(String id) {
    return _$deleteUserAsyncAction.run(() => super.deleteUser(id));
  }

  late final _$UsersStoreBaseActionController =
      ActionController(name: 'UsersStoreBase', context: context);

  @override
  dynamic changeObscurePassword() {
    final _$actionInfo = _$UsersStoreBaseActionController.startAction(
        name: 'UsersStoreBase.changeObscurePassword');
    try {
      return super.changeObscurePassword();
    } finally {
      _$UsersStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeObscureConfirmPassword() {
    final _$actionInfo = _$UsersStoreBaseActionController.startAction(
        name: 'UsersStoreBase.changeObscureConfirmPassword');
    try {
      return super.changeObscureConfirmPassword();
    } finally {
      _$UsersStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
obscurePassword: ${obscurePassword},
obscureConfirmPassword: ${obscureConfirmPassword},
user: ${user}
    ''';
  }
}
