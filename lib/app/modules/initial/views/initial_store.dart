import 'package:control_data/app/core/model/demands_model.dart';
import 'package:control_data/app/core/repositories/demands_repository.dart';
import 'package:mobx/mobx.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'initial_store.g.dart';

class InitialStore = InitialStoreBase with _$InitialStore;

abstract class InitialStoreBase with Store {
  final DemandsRepository _repository;

  ObservableList<DemandsModel> demandsList = ObservableList<DemandsModel>();

  InitialStoreBase(this._repository);

  Future<void> getAllDemands() async {
    try {
      var demands = await _repository.getAllDemands();

      demands.sort((a, b) => b.solicitationDate.compareTo(a.solicitationDate));

      demandsList.clear();
      demandsList.addAll(demands);
    } on PostgrestException catch (e) {
      print(e.message);
    } catch (e) {
      print(e);
    }
  }
}
