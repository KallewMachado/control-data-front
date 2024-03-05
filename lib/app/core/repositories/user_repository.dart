import 'dart:convert';
import 'package:control_data/app/core/model/auth_model.dart';
import 'package:control_data/app/core/store/app_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
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
  Future<void> updatePassword(String newPassword);
  Future<void> verifyOTP(String token, String email);
  Future<void> sendForgotPasswordFromEmail(String email);
  Future<void> failNewUser(String id);
}

class UserRepositoryImpl implements UserRepository {
  final _supabase = Supabase.instance.client;
  final _appStore = Modular.get<AppStore>();

  @override
  Future<AuthModel> createUser(AuthModel auth) async {
    try {
      _appStore.initFetch();
      final AuthResponse res = await _supabase.auth
          .signUp(email: auth.email, password: auth.password);

      User? result = res.user;

      AuthModel user =
          AuthModel(id: result!.id, email: result.email!, password: '');
      _appStore.endFetch();
      return user;
    } on AuthException catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<UserModel>> getAllUsers() async {
    try {
      _appStore.initFetch();
      List<UserModel> users = [];
      final data = await _supabase.from('users').select();
      var response = UserModel.fromJsonList(data);

      users.addAll(response);
      _appStore.endFetch();

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
      _appStore.initFetch();
      var response = await _supabase.from('users').insert(json).select();

      UserModel user = userModelFromJson(jsonEncode(response[0]));
      _appStore.endFetch();
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
      _appStore.initFetch();
      var response =
          await _supabase.from('users').update(json).eq('id', id).select();

      UserModel user = userModelFromJson(jsonEncode(response[0]));
      _appStore.endFetch();

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
      _appStore.initFetch();
      var response =
          await _supabase.from('users').delete().eq('id', id).select();

      UserModel user = userModelFromJson(jsonEncode(response[0]));
      _appStore.endFetch();
      return user;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> failNewUser(String id) async {
    try {
      _appStore.initFetch();
      await _supabase.auth.admin.deleteUser(id);

      _appStore.endFetch();
    } on PostgrestException catch (_) {
      rethrow;
    } on AuthException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updatePassword(String newPassword) async {
    try {
      await _supabase.auth.updateUser(UserAttributes(password: newPassword));
    } on AuthException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> sendForgotPasswordFromEmail(String email) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
    } on AuthException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> verifyOTP(String token, String email) async {
    try {
      await _supabase.auth.verifyOTP(
        token: token,
        type: OtpType.recovery,
        email: email,
      );
    } on AuthException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
