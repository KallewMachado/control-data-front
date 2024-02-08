// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_new_user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RegisterNewUserStore on _RegisterNewUserStoreBase, Store {
  late final _$obscurePasswordAtom =
      Atom(name: '_RegisterNewUserStoreBase.obscurePassword', context: context);

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

  late final _$obscureConfirmPasswordAtom = Atom(
      name: '_RegisterNewUserStoreBase.obscureConfirmPassword',
      context: context);

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

  late final _$_RegisterNewUserStoreBaseActionController =
      ActionController(name: '_RegisterNewUserStoreBase', context: context);

  @override
  dynamic changeObscurePassword() {
    final _$actionInfo = _$_RegisterNewUserStoreBaseActionController
        .startAction(name: '_RegisterNewUserStoreBase.changeObscurePassword');
    try {
      return super.changeObscurePassword();
    } finally {
      _$_RegisterNewUserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeObscureConfirmPassword() {
    final _$actionInfo =
        _$_RegisterNewUserStoreBaseActionController.startAction(
            name: '_RegisterNewUserStoreBase.changeObscureConfirmPassword');
    try {
      return super.changeObscureConfirmPassword();
    } finally {
      _$_RegisterNewUserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
obscurePassword: ${obscurePassword},
obscureConfirmPassword: ${obscureConfirmPassword}
    ''';
  }
}
