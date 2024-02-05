import 'dart:convert';
import 'package:control_data/app/core/model/auth_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:control_data/app/core/model/user_model.dart';

abstract class UserRepository {
  Future<AuthModel> createUser(AuthModel auth);
  Future<UserModel> login(AuthModel auth);
  Future<UserModel> newUser(Map<String, dynamic> json);
  Future<List<UserModel>> getAllUsers();
  Future<UserModel> updateUser(Map<String, dynamic> json, String id);
  Future<UserModel> deleteUser(String id);
  Future<void> logout();
}

class UserRepositoryImpl implements UserRepository {
  final _supabase = Supabase.instance.client;

  @override
  Future<AuthModel> createUser(AuthModel auth) async {
    try {
      final AuthResponse res = await _supabase.auth
          .signUp(email: auth.email, password: auth.password);

      User? result = res.user;

      AuthModel user =
          AuthModel(id: result!.id, email: result.email!, password: '');

      return user;
    } on AuthException catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<UserModel>> getAllUsers() async {
    try {
      List<UserModel> users = [];
      final data = await _supabase.from('users').select();
      var response = UserModel.fromJsonList(data);

      users.addAll(response);

      return users;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> login(AuthModel auth) async {
    try {
      final AuthResponse res = await _supabase.auth.signInWithPassword(
        email: auth.email,
        password: auth.password,
      );
      final User? user = res.user;

      final data =
          await _supabase.from('users').select().eq('id', '${user?.id}');

      UserModel? result = UserModel.fromJson(data[0]);

      return result;
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _supabase.auth.signOut();
    } on AuthException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> newUser(Map<String, dynamic> json) async {
    try {
      var response = await _supabase.from('users').insert(json).select();

      UserModel user = userModelFromJson(jsonEncode(response[0]));

      return user;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> updateUser(Map<String, dynamic> json, String id) async {
    try {
      var response =
          await _supabase.from('users').update(json).eq('id', id).select();

      UserModel user = userModelFromJson(jsonEncode(response[0]));

      return user;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> deleteUser(String id) async {
    try {
      var response =
          await _supabase.from('users').delete().eq('id', id).select();

      UserModel user = userModelFromJson(jsonEncode(response[0]));

      return user;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
