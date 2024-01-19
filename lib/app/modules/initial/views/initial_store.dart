import 'package:control_data/app/core/model/demands_model.dart';
import 'package:mobx/mobx.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'initial_store.g.dart';

class InitialStore = InitialStoreBase with _$InitialStore;

abstract class InitialStoreBase with Store {
  @observable
  List<DemandsModel> demandsList = [];

  Future<void> getDemands() async {
    try {} on PostgrestException catch (e) {
      print(e.message);
    } catch (e) {
      print(e.toString());
    }
  }
}
