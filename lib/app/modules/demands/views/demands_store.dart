// ignore_for_file: library_private_types_in_public_api

import 'package:control_data/app/core/model/demands_model.dart';
import 'package:control_data/app/core/repositories/demands_repository.dart';
import 'package:mobx/mobx.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'demands_store.g.dart';

class DemandsStore = DemandsStoreBase with _$DemandsStore;

abstract class DemandsStoreBase with Store {
  final DemandsRepository _repository;

  ObservableList<DemandsModel> demandsList = ObservableList<DemandsModel>();
  ObservableList<DemandsModel> demandsListByUser =
      ObservableList<DemandsModel>();

  DemandsStoreBase(this._repository);

  Future<void> createDemands(Map<String, dynamic> json) async {
    await _repository.createDemands(json);
  }

  Future<void> getAllDemands() async {
    try {
      var demands = await _repository.getAllDemands();

      demandsList.clear();
      demandsList.addAll(demands);
    } on PostgrestException catch (e) {
      print(e.message);
    } catch (e) {
      print(e);
    }
  }

  Future<void> getAllDemandsByUser(String userId) async {
    try {
      var demands = await _repository.getAllDemandsByUser(userId);

      demandsListByUser.clear();
      demandsListByUser.addAll(demands);
    } on PostgrestException catch (e) {
      print(e.message);
    } catch (e) {
      print(e);
    }
  }
}
