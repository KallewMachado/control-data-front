import 'dart:convert';
import 'package:control_data/app/core/model/demands_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class DemandsRepository {
  Future<DemandsModel> createDemands(Map<String, dynamic> json);
  Future<List<DemandsModel>> getAllDemands();
  // Future<List<DemandsModel>> getAllDemandsByUser(String userId);
  Future<DemandsModel> updateDemands(Map<String, dynamic> json, String id);
  Future<DemandsModel> deleteDemands(String id);
}

class DemandsRepositoryImpl implements DemandsRepository {
  final _supabase = Supabase.instance.client;

  @override
  Future<DemandsModel> createDemands(Map<String, dynamic> json) async {
    var response = await _supabase.from('demands').insert(json).select();

    DemandsModel demands = demandsModelFromJson(jsonEncode(response[0]));

    return demands;
  }

  @override
  Future<List<DemandsModel>> getAllDemands() async {
    List<DemandsModel> demandsList = [];
    var response = await _supabase.from('demands').select();

    var demands = DemandsModel.fromJsonList(response);

    demandsList.addAll(demands);

    return demands;
  }

  // @override
  // Future<List<DemandsModel>> getAllDemandsByUser(String userId) async {
  //   List<DemandsModel> demandsList = [];
  //   var response =
  //       await _supabase.from('demands').select().eq('user_id', userId);

  //   var demands = DemandsModel.fromJsonList(response);

  //   demandsList.addAll(demands);

  //   return demands;
  // }

  @override
  Future<DemandsModel> updateDemands(
      Map<String, dynamic> json, String id) async {
    var response =
        await _supabase.from('demands').update(json).eq('id', id).select();

    DemandsModel demands = demandsModelFromJson(jsonEncode(response[0]));

    return demands;
  }

  @override
  Future<DemandsModel> deleteDemands(String id) async {
    var response =
        await _supabase.from('demands').delete().eq('id', id).select();

    DemandsModel demands = demandsModelFromJson(jsonEncode(response[0]));

    return demands;
  }
}
