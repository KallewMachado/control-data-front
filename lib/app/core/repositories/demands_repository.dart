import 'dart:convert';
import 'package:control_data/app/core/model/demands_model.dart';
import 'package:control_data/app/core/store/app_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
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
  final _appStore = Modular.get<AppStore>();

  @override
  Future<DemandsModel> createDemands(Map<String, dynamic> json) async {
    try {
      _appStore.initFetch();
      var response = await _supabase.from('demands').insert(json).select();

      DemandsModel demands = demandsModelFromJson(jsonEncode(response[0]));
      _appStore.endFetch();
      return demands;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<DemandsModel>> getAllDemands() async {
    try {
      _appStore.initFetch();
      List<DemandsModel> demandsList = [];
      var response = await _supabase.from('demands').select();

      var demands = DemandsModel.fromJsonList(response);

      demandsList.addAll(demands);
      _appStore.endFetch();

      return demands;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  // @override
  // Future<List<DemandsModel>> getAllDemandsByUser(String userId) async {
  //   try {
  //     List<DemandsModel> demandsList = [];
  //     var response =
  //         await _supabase.from('demands').select().eq('user_id', userId);
  //     var demands = DemandsModel.fromJsonList(response);
  //     demandsList.addAll(demands);
  //     return demands;
  //   } on PostgrestException catch (_) {
  //     rethrow;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  @override
  Future<DemandsModel> updateDemands(
      Map<String, dynamic> json, String id) async {
    try {
      _appStore.initFetch();
      var response =
          await _supabase.from('demands').update(json).eq('id', id).select();

      DemandsModel demands = demandsModelFromJson(jsonEncode(response[0]));
      _appStore.initFetch();
      return demands;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DemandsModel> deleteDemands(String id) async {
    try {
      _appStore.initFetch();
      var response =
          await _supabase.from('demands').delete().eq('id', id).select();

      DemandsModel demands = demandsModelFromJson(jsonEncode(response[0]));
      _appStore.endFetch();
      return demands;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
