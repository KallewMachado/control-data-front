// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on HomeStoreBase, Store {
  late final _$selectionAtom =
      Atom(name: 'HomeStoreBase.selection', context: context);

  @override
  Set<Pages> get selection {
    _$selectionAtom.reportRead();
    return super.selection;
  }

  @override
  set selection(Set<Pages> value) {
    _$selectionAtom.reportWrite(value, super.selection, () {
      super.selection = value;
    });
  }

  late final _$HomeStoreBaseActionController =
      ActionController(name: 'HomeStoreBase', context: context);

  @override
  dynamic changeSelectionPage(Set<Pages> newSelection) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.changeSelectionPage');
    try {
      return super.changeSelectionPage(newSelection);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selection: ${selection}
    ''';
  }
}
