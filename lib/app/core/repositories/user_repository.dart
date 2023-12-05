import 'package:control_data/app/core/model/auth_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:control_data/app/core/model/user_model.dart';

abstract class UserRepository {
  Future<void> createUser(AuthModel auth);
  Future<UserModel> login(String user);
  Future<UserModel> newUser(String json);
  Future<List<UserModel>> getAllUsers(String json);
  Future<UserModel> updateUser(String json);
  Future<void> deleteUser(String json);
  Future<void> logout(String json);
}

class UserRepositoryImpl implements UserRepository {
  final _supabase = supabase.Supabase.instance.client;

  @override
  Future<void> createUser(AuthModel auth) async {
    try {
      await _supabase.auth.signUp(email: auth.email, password: auth.password);
    } on supabase.AuthException catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> deleteUser(String json) {
    throw UnimplementedError();
  }

  @override
  Future<List<UserModel>> getAllUsers(String json) {
    throw UnimplementedError();
  }

  @override
  Future<UserModel> login(String user) {
    throw UnimplementedError();
  }

  @override
  Future<void> logout(String json) {
    throw UnimplementedError();
  }

  @override
  Future<UserModel> newUser(String json) {
    throw UnimplementedError();
  }

  @override
  Future<UserModel> updateUser(String json) {
    throw UnimplementedError();
  }
}
