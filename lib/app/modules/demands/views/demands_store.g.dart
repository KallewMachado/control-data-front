// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'demands_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DemandsStore on DemandsStoreBase, Store {
  late final _$createDemandsAsyncAction =
      AsyncAction('DemandsStoreBase.createDemands', context: context);

  @override
  Future<void> createDemands(Map<String, dynamic> json) {
    return _$createDemandsAsyncAction.run(() => super.createDemands(json));
  }

  late final _$updateDemandsAsyncAction =
      AsyncAction('DemandsStoreBase.updateDemands', context: context);

  @override
  Future<void> updateDemands(Map<String, dynamic> json, String id) {
    return _$updateDemandsAsyncAction.run(() => super.updateDemands(json, id));
  }

  late final _$getAllDemandsAsyncAction =
      AsyncAction('DemandsStoreBase.getAllDemands', context: context);

  @override
  Future<void> getAllDemands() {
    return _$getAllDemandsAsyncAction.run(() => super.getAllDemands());
  }

  late final _$getAllDemandsByUserAsyncAction =
      AsyncAction('DemandsStoreBase.getAllDemandsByUser', context: context);

  @override
  Future getAllDemandsByUser(String userId) {
    return _$getAllDemandsByUserAsyncAction
        .run(() => super.getAllDemandsByUser(userId));
  }

  late final _$removeDemandAsyncAction =
      AsyncAction('DemandsStoreBase.removeDemand', context: context);

  @override
  Future<void> removeDemand(String id) {
    return _$removeDemandAsyncAction.run(() => super.removeDemand(id));
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
