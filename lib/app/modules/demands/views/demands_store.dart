// ignore_for_file: library_private_types_in_public_api

import 'package:control_data/app/core/model/demands_model.dart';
import 'package:control_data/app/core/repositories/demands_repository.dart';
import 'package:control_data/app/core/utils/hive_config.dart';
import 'package:mobx/mobx.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'demands_store.g.dart';

class DemandsStore = DemandsStoreBase with _$DemandsStore;

abstract class DemandsStoreBase with Store {
  final DemandsRepository _repository;
  final hive = HiveConfig();

  ObservableList<DemandsModel> demandsListByUser =
      ObservableList<DemandsModel>();

  ObservableList<DemandsModel> demandsList = ObservableList<DemandsModel>();

  DemandsStoreBase(this._repository);

  @action
  Future<void> createDemands(Map<String, dynamic> json) async {
    var response = await _repository.createDemands(json);
    demandsList.add(response);
  }

  int getYearsOld(DateTime dateBirth) {
    int yearsOld = (DateTime.now().difference(dateBirth).inDays / 365).round();
    return yearsOld;
  }

  String getFullName(String name) {
    String fullName = '${name.split(' ').first} ${name.split(' ').last}';
    return fullName;
  }

  @action
  Future<void> updateDemands(Map<String, dynamic> json, String id) async {
    var response = await _repository.updateDemands(json, id);

    demandsList.removeWhere((demand) => demand.id == response.id);
    demandsList.add(response);
  }

  @action
  Future<void> getAllDemands() async {
    try {
      var demands = await _repository.getAllDemands();

      demands.sort((a, b) => a.solicitationDate.compareTo(b.solicitationDate));

      demandsList.clear();
      demandsList.addAll(demands);
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @action
  getAllDemandsByUser(String userId) async {
    List<DemandsModel> listAux = [];
    for (var demand in demandsList) {
      if (demand.userId == userId) {
        listAux.add(demand);
      }
    }
    demandsListByUser.clear();
    demandsListByUser.addAll(listAux);
  }

  @action
  Future<void> removeDemand(String id) async {
    var response = await _repository.deleteDemands(id);

    demandsList.removeWhere((demand) => demand.id == response.id);
  }
}
